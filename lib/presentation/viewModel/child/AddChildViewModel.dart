import 'dart:convert';
import 'dart:typed_data';

import 'package:core/Notification/MyNotification.dart';
import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/data/body/user/profile/FileDataBody.dart';
import 'package:my_ios_app/data/body/user/profile/UploadUserAvatarBody.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/presentation/state/formState/child/AddChildFormState.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/AddChildUseCase.dart';
import 'package:my_ios_app/useCase/child/AdddataUseVase.dart';
import 'package:my_ios_app/useCase/user/GetUserProfileUseCase.dart';

class AddChildViewModel extends BaseViewModel {
  AddChildViewModel(super.initialState) {
    initDate();
  }

  void initDate() {
    birthDateTime.day = 2;
    birthDateTime.month = 10;
    birthDateTime.year = Get.locale == const Locale('fa', 'IR') ? 1398 : 2016;
  }

  final MyNotification _notification = GetIt.I.get();
  AppState uiState = AppState.idle;

  ImageFileModel? selectedImage;
  final MyImagePicker _myImagePicker = GetIt.I.get();

  final AddChildFormState _formState = AddChildFormState();
  final EditChildFormState _formStateEdit = EditChildFormState();
  final AddDateFormState _formStateDate = AddDateFormState();

  BirthDateTime birthDateTime = BirthDateTime();
  final formState = GlobalKey<FormState>();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  onChildDateChange(String firstName) =>
      _formStateDate.executionDate = firstName;
  onChildFirstNameChange(String firstName) =>
      _formState.childFirstName = firstName;
  onChildGenderChange(int firstName) =>
      _formState.gender = firstName;

  onChildLastNameChange(String lastName) => _formState.childLastName = lastName;

  onDayChange(dynamic day) => birthDateTime.day = day ?? 0;

  onMonthChange(dynamic month) => birthDateTime.month = month ?? 0;

  onYearChange(dynamic year) => birthDateTime.year = year ?? 0;
  void submitDate() {
    AdddataUseVase().invoke(MyFlow(flow: (appState) {
      print(_formStateDate.executionDate);
      print(appState.isSuccess);
      if (appState.isSuccess) {
        messageService.showSnackBar("جلسه شما با موفقیت رزرو شد.");
        _navigationServiceImpl.pop();
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '', duration: Duration(seconds: 3));
      }
    }), data: _formStateDate.createBody());
  }

  void submitDateGetReservedMeeting() {
    AdddataUseVase().getReservedMeeting(MyFlow(flow: (appState) {
      print(appState.isSuccess);
      if (appState.isSuccess) {}
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }));
  }

  void submitChangeEmpowermentMeetingExecutionDate() {
    AdddataUseVase().ChangeEmpowermentMeetingExecutionDate(
        MyFlow(flow: (appState) {
      print(_formStateDate.executionDate);
      print(appState.isSuccess);
      if (appState.isSuccess) {
        messageService.showSnackBar("جاسه شما با موفقیت تغییر پیدا کرد ", duration: Duration(seconds: 3));
        _navigationServiceImpl.pop();
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '', duration: Duration(seconds: 3));
      }
    }), data: _formStateDate.createBody());
  }

  void cancelEmpowermentMeeting() {
    AdddataUseVase().cancelEmpowermentMeeting(MyFlow(flow: (appState) {
      print(_formStateDate.executionDate);
      print(appState.isSuccess);
      if (appState.isSuccess) {
        messageService.showSnackBar("جلسه شما حدف شد.");
        _navigationServiceImpl.pop();
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }));
  }

  void submit() {
    if (birthDateTime.day == 0 ||
        birthDateTime.month == 0 ||
        birthDateTime.year == 0) {
      messageService.showSnackBar('enter_date'.tr);
      return;
    }

    // if(selectedImage == null){
    //   messageService.showSnackBar('لطفا یک عکس اضافه کنید');
    // }

    _formState.birtDate = Get.locale.isPersian
        ? birthDateTime.createPersianDate().toIso8601String()
        : birthDateTime.createDate().toIso8601String();
    AddChildUseCase().invoke(MyFlow(flow: (appState) {
      print(appState.isSuccess);
      print("appState.isSuccess");
      if (appState.isSuccess) {
        // _notification.publish('GetChildViewModel', true);
        _notification.publish('NewHomeViewModel', true);
        _notification.publish('MainViewModel', HomeNavigationEnum.Home.value);
        _navigationServiceImpl.pop();
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
      uiState = appState;
      refresh();
    }), data: _formState.createBody(selectedImage));
  }

  void submitEditInit(ChildsItem child) {
    _formStateEdit.childFirstName = child.childFirstName!;
    _formStateEdit.childLastName = child.childLastName!;
    _formStateEdit.userChildId = child.id.toString();

    // Call the function
  }

  void submitEdit(ChildsItem child) {
    if (_formState.childLastName.isNotEmpty) {
      _formStateEdit.childLastName = _formState.childLastName;

    }

    if (_formState.childFirstName.isNotEmpty) {
      _formStateEdit.childFirstName = _formState.childFirstName;
    }
    if (_formState.gender>-1) {
      _formStateEdit.gender = _formState.gender;
    }
    print("_formState.gender");

    print(_formState.gender);
    // Call the function
    String result = getUseDataEdit(child);
  }

  String getUseDataEdit(ChildsItem child) {
    String? result;
    print("TTTTTTTTTTTTTTTTTTTT" + _formStateEdit.childFirstName);

    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        if (res.id != null) {
          result = res.id.toString();
          final ImageFileModel? imageS;
          print("result" + result!);
          _formStateEdit.id = result!;

          if (selectedImage == null && child.childPicture?.content != null) {
            final picture = child.childPicture;

        imageS = ImageFileModel(
  name: picture?.fileName ?? 'defaultName',
  mimType: picture?.mimeType ?? 'application/octet-stream',
  content: picture?.content ?? '',
  Id: picture?.id ?? '',
);

            print(
                "IMAGE TTTTTTTTTTTTT" + child.childPicture!.content.toString());
            print("IMAGE BBBBBBB" + imageS!.content.toString());
          } else {
            imageS = selectedImage;
          }

          if (_formState.childLastName.isNotEmpty) {
            _formStateEdit.childLastName = _formState.childLastName;
          }
          if (_formState.childFirstName.isNotEmpty) {
            _formStateEdit.childFirstName = _formState.childFirstName;
          }
          if (_formState.gender>-1) {
            _formStateEdit.gender = _formState.gender;
          }
          print("TTTTTTTTTTTTTTTTTTTT" + _formStateEdit.childFirstName);

          EditChildUseCase().invoke(MyFlow(flow: (appState) {
            print("yyyy" + "${appState.isSuccess}");

            // if (appState.isFailed) {
            //   messageService
            //       .showSnackBar(appState.getErrorModel?.message ?? '');
            // }
            if (appState.isSuccess) {
              print("vvvvvvvvvvv" + "${appState.isSuccess}");

              _notification.publish('NewHomeViewModel', true);
              _notification.publish(
                  'MainViewModel', HomeNavigationEnum.WorkShops.value);
              _navigationServiceImpl.pop();
            }
            uiState = appState;
            refresh();
          }), data: _formStateEdit.createBody(imageS));
        }
      }
    }));
    refresh();
    return result ?? ""; // return an empty string if result is null
  }

  String getUseData() {
    String? result;

    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        if (res.userName != null) {
          result = res.userName;
          print("result" + result!);
          _formState.userName = result!;
          if (birthDateTime.day == 0 ||
              birthDateTime.month == 0 ||
              birthDateTime.year == 0) {
            messageService.showSnackBar('enter_date'.tr);
            return;
          }
          // if(selectedImage == null){
          //   messageService.showSnackBar('لطفا یک عکس اضافه کنید');
          // }
          print(_formState.userName);
          if (formState.currentState?.validate() == true) {
            _formState.birtDate = Get.locale.isPersian
                ? birthDateTime.createPersianDate().toIso8601String()
                : birthDateTime.createDate().toIso8601String();
            AddChildUseCase().invoke(MyFlow(flow: (appState) {
              if (appState.isFailed) {
                messageService
                    .showSnackBar(appState.getErrorModel?.message ?? '');
              }
              if (appState.isSuccess) {
                // _notification.publish('GetChildViewModel', true);
                _notification.publish('NewHomeViewModel', true);
                _notification.publish(
                    'MainViewModel', HomeNavigationEnum.WorkShops.value);
                _navigationServiceImpl.pop();
              }
              uiState = appState;
              refresh();
            }), data: _formState.createBody(selectedImage));
          }
        }
      }
    }));
    refresh();
    return result ?? ""; // return an empty string if result is null
  }

  void getImage() async {
    selectedImage = await _myImagePicker.pickImage();
    selectedImage?.Id = '00000000-0000-0000-0000-000000000000';
    if (selectedImage != null) {
      refresh();
    }
  }

  void addImage() {
    getImage();
  }
}

extension ImageFileModelExtension on ImageFileModel {
  UploadUserAvatarBody createBody() {
    return UploadUserAvatarBody(
      mobileNumber: '',
      fileData: FileDataBody(
          content: content, mimeType: mimType, fileName: name, Id: Id),
    );
  }

  FileDataBody createFileDataBody() =>
      FileDataBody(content: content, mimeType: mimType, fileName: name, Id: Id);

  Uint8List getFileFormBase642() {
    return base64Decode(content);
  }
}
