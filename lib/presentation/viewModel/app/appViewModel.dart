import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/presentation/ui/dialog/UpdateDialog.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/app/AppVersionUseCase.dart';
import 'package:my_ios_app/useCase/user/GetUserProfileUseCase.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel(super.initialState) {
    Logger.d('initialized app data');
    initAppData();
  }

  void initAppData() async {
    await addCultureInterceptor();
    if (!kIsWeb) {
      checkVersion();
    }
  }

  static AppViewModel getInstance = AppViewModel(AppState.idle);

  static Future<void> initInterceptors() async {
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<AuthorizationInterceptor>());
    // GetIt.I
    //     .get<KanoonHttp>()
    //     .addInterceptor(GetIt.I.get<RefreshTokenInterceptor>());
    // RefreshTokenInterceptorUseCase().invoke();
  }

  void getUseData() {
    GetUserProfileUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is GetUserProfileResponse) {
        GetUserProfileResponse res = appState.getData;
        if (res.userAvatar?.content != null) {
          GetIt.I
              .get<LocalSessionImpl>()
              .insertData({UserSessionConst.image: res.userAvatar!.content!});
        }
      }
    }));
  }

  void checkVersion() {
    AppVersionUseCase().invoke(MyFlow(flow: (appState) {
      Logger.d(appState);
      if (appState.isSuccess) {
        if (appState.getData is bool) {
          if (appState.getData == true) {
            GetIt.I.get<NavigationServiceImpl>().dialog(
                  const UpdateDialog(
                      link:
                          'https://back.mamakschool.ir/api/AppVersion/GetLatestAppVersionFile'),
                );
          }
        }
      }
    }));
  }

  @override
  Future<void> close() {
    GetIt.I.get<Client>().close();
    return super.close();
  }

  addCultureInterceptor() async {
    var cultureInterceptor = GetIt.I.get<CultureInterceptor>();
    cultureInterceptor.setCulture(Get.locale?.toLanguageTag() ?? '');
    GetIt.I.get<KanoonHttp>().addInterceptor(cultureInterceptor);
  }
}
