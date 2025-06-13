import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/state/formState/user/change_password_form_state.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/user/ChangePasswordUseCase.dart';

class ChangePasswordViewModel extends BaseViewModel {
  ChangePasswordViewModel(super.initialState) {
    fillMobile();
  }

  final formKey = GlobalKey<FormState>();
  ChangePasswordFormState formState = ChangePasswordFormState();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  Function(String) get onCurrentPasswordChange =>
      (mobile) => formState.currentPassword = mobile;

  Function(String) get onPasswordChange =>
      (mobile) => formState.password = mobile;

  Function(String) get onConfirmPasswordChange =>
      (mobile) => formState.confirmPassword = mobile;

  void fillMobile() async {
    var mobile = await session.getData(UserSessionConst.mobile);
    formState.mobile = mobile;
  }

  void onSubmitClick() {
    print(formKey.currentState.toString());
    // if (formKey.currentState?.validate() == true) {
    if (formState.password != formState.confirmPassword) {
      messageService.showSnackBar('not_same_psw'.tr);
      return;
    }
    // if (formState.mobile == '') {
    //   messageService.showSnackBar('pls_login_msg'.tr);
    //   return;
    // }
    ChangePasswordUseCase().invoke(mainFlow, data: formState.createBody());
    _navigationServiceImpl.pop();
    // }
  }
}
