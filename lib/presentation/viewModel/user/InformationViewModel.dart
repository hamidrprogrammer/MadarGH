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

import '../../../data/body/user/information/InformationBodey.dart';
import '../../../useCase/user/InformationUseCase.dart';
import '../../state/formState/user/InformationForm.dart';

class InformationViewModel extends BaseViewModel {
  InformationBody? _info;
  UserInfo? _infoUser;

  int maritalStatus = 0;
  InformationBody? get info => _info;
  UserInfo? get infoUser => _infoUser;

  NavigationServiceImpl navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();

  var formKey = GlobalKey<FormState>();
  InformationFormState formState = InformationFormState();
  var factor;

  AppState uiState = AppState.idle;
  AppState pState = AppState.idle;
  AppState cState = AppState.idle;
  DropDownModel? selectedProvince;
  DropDownModel? selectedCity;

  InformationViewModel(super.initialState) {
    // InformationViewModelBy = Get.locale.isPersian ? InformationViewModelBy.mobile : InformationBy.mobile;
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
  Future<void> fetchDatat() async {
    try {
      final data = await InformationUseCase().getData();
      _info = InformationBody.fromJson(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchgetUser() async {
    try {
      // Fetch data from the `getDataDetails` function
      final data = await InformationUseCase().getDataDetails();

      // Parse the fetched data into the `UserInfo` model
      _infoUser = UserInfo.fromJson(data);
    } catch (e) {
      // Handle any errors that occur during the fetch or JSON parsing
      print('Error occurred: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      final data = await InformationUseCase().getData();

      _info = InformationBody.fromJson(data);

      formState.firstName = _info?.firstName;
      formState.lastName = _info?.lastName;
      formState.fatherEducation = _info?.fatherEducation;
      formState.fatherJobStatus = _info?.fatherJobStatus;
      formState.motherJobTitle = _info?.motherJobTitle;
      formState.fatherJobTitle = _info?.fatherJobTitle;
      formState.motherJobStatus = _info?.motherJobStatus;
      formState.mentalPeace = _info?.mentalPeace;
      formState.health = _info?.health;
      formState.support = _info?.support;
      formState.maritalStatus = _info?.maritalStatus;
      formState.motherEducation = _info?.motherEducation;
    } catch (e) {
      print(e);
    }
  }

  Function(String) get onFirstNameChange =>
      (value) => formState.firstName = value;

  Function(String) get onLastNameChange =>
      (value) => formState.lastName = value;

  Function(int) get onEducationFatherStatusChange =>
      (value) => formState.fatherEducation = value;
  Function(int) get onJobFatherStatusChange =>
      (value) => formState.fatherJobStatus = value;

  Function(String) get onMotherJobTitle =>
      (value) => formState.motherJobTitle = value;
  Function(String) get onFatherJobTitle =>
      (value) => formState.fatherJobTitle = value;
  Function(int) get onEducationStatusChange =>
      (value) => formState.motherEducation = value;
  Function(int) get onJobStatusChange =>
      (value) => formState.motherJobStatus = value;
  Function(int) get onMaritalStatusChange => (value) {
        formState.maritalStatus = value;
      };
  Function(int) get onMentalPeaceStatusChange =>
      (value) => formState.mentalPeace = value;
  Function(int) get onSupportStatusChange =>
      (value) => formState.support = value;
  Function(int) get onHealthStatusChange => (value) => formState.health = value;

  // Function(bool) get onTermsChange => (value) => formState.terms = value;

  Function() register() {
    return () {
      print(formState.toString());
      InformationUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          // navigationServiceImpl.replaceTo(AppRoute.verification, {
          //   'email': formState.email ,
          //   'mobil':formState.mobile,
          //   'id': appState.getData.toString()
          // });
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
}
