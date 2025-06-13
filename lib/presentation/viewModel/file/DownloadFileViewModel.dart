import 'package:core/share/ShareFile.dart'
    if (dart.library.html) 'package:core/fileSaver/WebFileSaver.dart';
import 'package:feature/deviceInfo/my_device_info.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/file/DownloadFileUseCase.dart';
// import 'package:permission_handler/permission_handler.dart';

class DownloadFileViewModel extends BaseViewModel {
  DownloadFileViewModel(super.initialState);

  // MyDeviceInfo deviceInfo = GetIt.I.get<MyDeviceInfo>();
  var askedForPermission = false;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  void downloadFile(String fileName) async {
    if (!kIsWeb) {
      // if (!askedForPermission) {
      //   var granted = await hasPermission;
      //   if (granted) {
      //     askedForPermission = true;
      //   } else {
      //     return;
      //   }
      // }
    }

    DownloadFileUseCase().invoke(MyFlow(
      flow: (appState) async {
        if (appState.isSuccess) {
          var data = appState.getData;

          // if (kIsWeb) {
          saveFile(data);
          // } else {
          //   var path = await ShareFile.saveFile(data);
          //   ShareFile.openFile(path);
          // }

          _navigationServiceImpl.pop();
          // _navigationServiceImpl.navigateTo(AppRoute.shotViewer, data);
        }
      },
    ), data: fileName);
  }

  // Future<bool> get hasPermission async {
  //   var deviceData = await deviceInfo.getDeviceInfo();
  //   if (deviceData.sdkInt >= 30) return true;
  //   try {
  //     PermissionStatus permissionStatusStorage =
  //         await Permission.storage.request();
  //     if (permissionStatusStorage != PermissionStatus.granted) {
  //       return false;
  //     }
  //     if (deviceData.sdkInt >= 30) {
  //       PermissionStatus permissionStatusManageExternalStorage =
  //           await Permission.manageExternalStorage.request();
  //       if (permissionStatusManageExternalStorage != PermissionStatus.granted) {
  //         return false;
  //       }
  //     }
  //     return true;
  //   } catch (e) {
  //     return true;
  //   }
  // }

  Future<void> _launchUrl(Uri uri) async {
    
  }
}
