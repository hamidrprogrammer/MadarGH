import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/network/NetworkFactory.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

var sl = GetIt.instance;

class NetworkModule {
  static Future<void> initNetworkModule() async {
    sl.registerLazySingleton(() => NetworkFactory.createKanoonDio);
    sl.registerLazySingleton(() => NetworkFactory.getKanoonHttp(sl()));
    sl.registerLazySingleton(
        () => CultureInterceptor(culture: Get.locale?.toLanguageTag() ?? ''));
    var token =
        await sl.get<LocalSessionImpl>().getData(UserSessionConst.token);
    var refreshToken =
        await sl.get<LocalSessionImpl>().getData(UserSessionConst.retoken);

    onFailAuth() {
      // sl.get<NavigationServiceImpl>().off(AppRoute.login);
    }

    sl.registerLazySingleton(() => AuthorizationInterceptor(
        token: token, refreshToken: refreshToken, onFailAuth: onFailAuth()));
  }
}
