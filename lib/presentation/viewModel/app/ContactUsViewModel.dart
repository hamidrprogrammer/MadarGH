import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_ios_app/data/serializer/app/ContactUsResponse.dart';
import 'package:my_ios_app/presentation/state/formState/app/ContactUsFormState.dart';
import 'package:my_ios_app/presentation/uiModel/app/ContactUsUiModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/app/ContactUsUseCase.dart';
import 'package:my_ios_app/useCase/app/GetContactUsUseCase.dart';

class ContactUsViewModel extends BaseViewModel {
  ContactUsViewModel(super.initialState) {
    getData();
  }

  ContactUsUiModel contactUsData = ContactUsUiModel();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  AppState formUiState = AppState.idle;
  AppState dataState = AppState.idle;

  ContactUsFormState formState = ContactUsFormState();
  final formKey = GlobalKey<FormState>();

  // onNameChange(String name) => formState.fullName = name;
  // onGenderChange(String name) => formState.gender = name;
  // onEmailChange(String email) => formState.email = email;
  //
  // onMobileChange(String mobile) => formState.mobile = mobile;

  onSubChange(int sub) => formState.contentCategoryId = sub;

  onTextChange(String text) => formState.message = text;

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void getData() {
    GetContactUsUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is ContactUsResponse) {
        ContactUsResponse data = appState.getData;
        // LatLng latLng = LatLng(
        //     double.tryParse(data.latitude?.toString() ?? '0') ?? 0.0,
        //     double.tryParse(data.longitude?.toString() ?? '0') ?? 0.0);
        //
        // mapController.move(latLng, 15.0);
        // contactUsData = ContactUsUiModel(
        //   address: data.address ?? '',
        //   phone: data.tellNumber ?? '',
        //   latLng: latLng,
        // );
      }
      dataState = appState;
      refresh();
    }));
  }

  void submitForm() {
   
    if (formState.message == '') {
      messageService.showSnackBar('enter_text'.tr);
     
      return;
    }
    print(formState.contentCategoryId);


    if (formState.message == ''||formState.contentCategoryId < 0 ) {
      messageService.showSnackBar('لطفا همه فیلد ها را پر کنید ');

      return;
    }
      ContactUsUseCase().invoke(MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          messageService.showSnackBar('success_sent'.tr);
           _navigationServiceImpl.pop();
        }

        formUiState = appState;
        refresh();
      }), data: formState.createBody());
    
  }
}
