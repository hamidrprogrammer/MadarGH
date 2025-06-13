import 'package:core/Notification/MyNotification.dart';
import 'package:core/imagePicker/MyImagePicker.dart';
import 'package:feature/poolakey/poolakey_helper.dart';
import 'package:my_ios_app/presentation/translation.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

var sl = GetIt.instance;

class AppModule {
  static Future<void> initModules() async {
    // GetIt.I.registerSingleton<RouteObserver>(RouteObserver());
    // GetIt.I.registerSingleton<RecaptchaSolver>(RecaptchaSolver.factory());
    var keys = await MamakTranslation.getKeys();
    sl.registerFactory(() => MamakTranslation(keys));
    // GetIt.I.registerSingleton(MamakTranslation(keys));
    sl.registerLazySingleton(() => NavigationServiceImpl());
    // GetIt.I.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    sl.registerLazySingleton(() => MessagingServiceImpl());
    // GetIt.I.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    sl.registerLazySingleton(() => LocalSessionImpl());
    // GetIt.I.registerSingleton<LocalSessionImpl>(LocalSessionImpl());

    // GetIt.I.registerSingleton<RefreshTokenInterceptor>(
    //   RefreshTokenInterceptor(
    //     api: GetIt.I.get<KanoonHttp>(),
    //     failedFunc: () {
    //       GetIt.I.get<NavigationServiceImpl>().off(AppRoute.login);
    //     },
    //   ),
    // );
    // GetIt.I.registerSingleton<ApiServiceImpl>(ApiServiceImpl(
    //     interceptor: await GetIt.I
    //         .get<LocalSessionImpl>()
    //         .getData(UserSessionConst.token)));
    sl.registerLazySingleton(() => MyNotification());
    // GetIt.I.registerSingleton<MyNotification>(MyNotification());
    sl.registerLazySingleton(() => MyImagePicker());
    // GetIt.I.registerLazySingleton(() => MyImagePicker());
    // GetIt.I.registerLazySingleton(() => MyDeviceInfo());
    sl.registerLazySingleton<PoolakeyHelper>(() => PoolakeyHelper());
  }
}
