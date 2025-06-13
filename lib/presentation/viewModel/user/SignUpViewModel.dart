import 'package:core/utils/logger/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/presentation/state/formState/user/RegisterFormState.dart';
import 'package:my_ios_app/presentation/ui/main/DropDownFormField.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/location/city_use_case.dart';
import 'package:my_ios_app/useCase/location/provinces_use_case.dart';
import 'package:my_ios_app/useCase/subscribe/GetSubscribeUseCase.dart';
import 'package:my_ios_app/useCase/user/SignUpUseCase.dart';

enum SignUpBy { email, mobile }

extension SignUpByExtension on SignUpBy {
  bool get isEmail => this == SignUpBy.email;

  bool get isMobile => this == SignUpBy.mobile;
}

class SignUpViewModel extends BaseViewModel {
  SignUpBy? signUpBy;

  NavigationServiceImpl navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  var formKey = GlobalKey<FormState>();
  RegisterFormState formState = RegisterFormState();

  AppState uiState = AppState.idle;
  AppState pState = AppState.idle;
  AppState cState = AppState.idle;
  DropDownModel? selectedProvince;
  DropDownModel? selectedCity;

  SignUpViewModel(super.initialState) {
    // signUpBy = Get.locale.isPersian ? SignUpBy.mobile : SignUpBy.mobile;
    getRecaptchaToken();
    // fetchSubscribes();
    // fetchProvinces();
  }

  AppState subscribesState = AppState.idle;

  void fetchSubscribes() {
    GetSubscribeUseCase().invoke(
      MyFlow(
        flow: (subscribesState) {
          this.subscribesState = subscribesState;
        },
      ),
    );
  }

  void fetchCityByProvinceId(String provinceId) {
    CityUseCase().invoke(MyFlow(
      flow: (appState) {
        cState = appState;
        refresh();
      },
    ), data: provinceId);
  }

  bool get isValid => formKey.currentState?.validate() == true;

  Function(String) get onMobileChange => (value) => formState.mobile = value;

  Function(String) get onFirstNameChange =>
      (value) => formState.firstName = value;

  Function(String) get onLastNameChange =>
      (value) => formState.lastName = value;

  Function(String) get onPasswordChange =>
      (value) => formState.password = value;

  Function(String) get onConfirmPasswordChange =>
      (value) => formState.confirmPassword = value;

  Function(String) get onEmailChange => (value) => formState.email = value;

  // Function(bool) get onTermsChange => (value) => formState.terms = value;

  Function() register() {
    print("TTTTTTTTTT");
    return () {
      if (formState.email == null && formState.mobile == null) {
        messageService.showSnackBar("enter_username_or_mobile".tr);
        return;
      }

      if (formState.password != formState.confirmPassword) {
        messageService.showSnackBar('not_same_psw'.tr);
        return;
      }

      if (kIsWeb) {
        if (formState.token == null) {
          messageService.showSnackBar("enter_captcha".tr);
          return;
        }
      }
      print(formState.toString());
      SignUpUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          navigationServiceImpl.replaceTo(AppRoute.verification, {
            'email': formState.email,
            'mobil': formState.mobile,
            'id': appState.getData.toString()
          });
        }
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        uiState = appState;
        refresh();
      }), data: formState.getBody());
    };
  }

  void fetchProvinces() {
    ProvinceUseCase().invoke(MyFlow(flow: (appState) {
      pState = appState;
      refresh();
    }));
  }

  Function(int?) onItemChanged() {
    return (value) {
      if (value != null) {
        // formState.subscribeId = value;
      }
    };
  }

  Function() gotoLoginPage() => () {
        navigationServiceImpl.replaceTo(AppRoute.login);
      };

  onProvinceChange(dynamic newProvince) {
    selectedCity = null;
    selectedProvince =
        DropDownModel(data: newProvince, name: newProvince?.provinceName ?? '');
    if (newProvince != null && newProvince.id != null) {
      fetchCityByProvinceId(newProvince.id.toString());
    }
    refresh();
  }

  onCityChange(dynamic newCity) {
    selectedCity = DropDownModel(data: newCity, name: newCity?.cityName ?? '');
    refresh();
  }

  void getRecaptchaToken() async {
    // var token = await GetIt.I.get<RecaptchaSolver>().generateToken();
    // Logger.d('generated token is $token');
  }

  onChangeToken(String token) {
    Logger.d('received token that is $token');
    formState.token = token;
  }

  void onChangeSignUpBy(SignUpBy? value) {
    if (value != null) {
      formState.email = '';
      formState.mobile = '';
      signUpBy = value;
      refresh();
    }
  }
}
