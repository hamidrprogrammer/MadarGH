import 'dart:convert';
import 'dart:typed_data';

import 'package:core/imagePicker/ImageFileModel.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:my_ios_app/data/body/user/profile/FileDataBody.dart';
import 'package:my_ios_app/data/body/user/profile/UploadUserAvatarBody.dart';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/subscribe/GetRemainingDayUseCase.dart';
import 'package:my_ios_app/useCase/user/GetUserProfileUseCase.dart';
import 'package:my_ios_app/useCase/user/SetUserAvatarUseCase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../../useCase/user/InformationUseCase.dart';

class ProfileViewModel extends BaseViewModel {
  AppState uploadState = AppState.idle;
  AppState userState = AppState.idle;
  ImageFileModel? selectedImage;
  final MyImagePicker _myImagePicker = GetIt.I.get();
  final NavigationServiceImpl _navigationServiceImpl =
      GetIt.I.get<NavigationServiceImpl>();
  final LocalSessionImpl _localSessionImpl = GetIt.I.get();

  ProfileViewModel(super.initialState) {
    getUseData();
    getRemainingDay();
    getRemainingSupport();
    getUserInfo();
  }

  get getUserFullName async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.fullName);
  get getUserID async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.id);
  get getUserDay async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionDay.day);
  get getMotherName async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserInfoSessionDay.name);
  get getUserMetting async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionSupport.support);
  get getUserImage async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.image);
  Future<void> getUserInfoUpdate(String name,String lastName ) async {
    print('"lastNames"');
    print(name);
    // final prefs = await SharedPreferences.getInstance();
    String? jsonString = "prefs.getString(UserInfoSessionDay.name)" ;
    Map<String, dynamic> data = jsonDecode(jsonString!);

    // Update firstName and lastName
    data['firstName'] = name;
    data['lastName'] = lastName;
    InformationUseCase().invoke(MyFlow(flow: (appState) {

      // prefs.setString(UserSessionConst.fullName, "${name} ${lastName}");
      getUserInfo();
      if (appState.isSuccess) {

        _navigationServiceImpl.pop();
        // navigationServiceImpl.replaceTo(AppRoute.verification, {
        //   'email': formState.email ,
        //   'mobil':formState.mobile,
        //   'id': appState.getData.toString()
        // });
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }

      refresh();
    }), data: data);
  }
  Future<void> getUserInfo() async {
    print("getUserInfo");

    GetUserProfileUseCase().invokeInfoUser(MyFlow(flow: (appState)  {
      if (appState.isSuccess && appState.getData.isNotEmpty ) {
        print("appState.getData");
        print(appState.getData);
        // SharedPreferences.getInstance().then((prefs) {
        //   // String itemJson = jsonEncode(appState.getData.toJson());
        //   prefs.setString(UserInfoSessionDay.name, appState.getData);
        //   refresh();


        // });



        // Save data to SharedPreferences

      }}


    ));




  }
  void getImage() async {
    var avatarId = selectedImage?.Id ?? '00000000-0000-0000-0000-000000000000';
    selectedImage = await _myImagePicker.pickImage();
    selectedImage?.Id = avatarId;
    if (!uploadState.isLoading && selectedImage != null) {
      SetUserAvatarUseCase().invoke(
        MyFlow(
          flow: (appState) {
            if (appState.isSuccess) {
              _localSessionImpl
                  .insertData({UserSessionConst.image: selectedImage!.content});
              getUseData();
            }
            if (appState.isFailed) {
              messageService
                  .showSnackBar(appState.getErrorModel?.message ?? '');
            }
            uploadState = appState;
            refresh();
          },
        ),
        data: selectedImage?.createBody(),
      );
    }
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void getUseData() {
    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        print(res);
        if (res.userName != null) {
          _localSessionImpl
              .insertData({UserSessionConst.userName: res.userName!});
        }
        getRemainingDay();
        if (res.userAvatar?.content != null) {
          selectedImage = ImageFileModel(
              name: res.userAvatar?.fileName ?? '',
              mimType: res.userAvatar?.mimeType ?? '',
              content: res.userAvatar?.content ?? '',
              Id: res.userAvatar?.id ?? '00000000-0000-0000-0000-000000000000');
          _localSessionImpl
              .insertData({UserSessionConst.image: res.userAvatar!.content!});
        }
      }
      userState = appState;
      refresh();
    }));
  }

  void getRemainingSupport() async {
    String? count;
    GetRemainingDayUseCase().invokeSupport(MyFlow(flow: (appState)  {


        print("invokeSupport=================================");

        count = appState.getData;
        // _localSessionImpl.insertData({UserSessionSupport.support: 'true'});


        // SharedPreferences.getInstance().then((prefs) {
        //   prefs.setString('isUserMeeting',count.toString() );  // Toggle the boolean
        //    // Reload after saving
        // });
        // print(count);
        // SharedPreferences.getInstance().then((prefs) {

        //    final _isLoggedIn = prefs.getString('isUserMeeting') ?? 'false';
        //    print("invokeSupport=======================s=========="+_isLoggedIn.toString());


        // });

        // Retrieve the boolean value

        refresh();

        // You can publish a notification here if needed
        // GetIt.I.get<MyNotification>().publish('MainViewModel', count);

    }));
  }
  void getRemainingDay() async {
    String? count;
    GetRemainingDayUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        count = appState.getData.toString();
        print("count======");
        print(count);

        _localSessionImpl.insertData({UserSessionDay.day: '${count}'});
        refresh();

        // You can publish a notification here if needed
        // GetIt.I.get<MyNotification>().publish('MainViewModel', count);
      } else {
        _localSessionImpl.insertData({UserSessionDay.day: '${0}'});
      }
    }));
  }

  void pickImage() {
    getImage();
  }

  void gotoAddChildPage() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
  }

  void gotoEditChildPage() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
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

  Uint8List getFileFormBase64() {
    return base64Decode(content);
  }
}
