import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:core/dioNetwork/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/dioNetwork/interceptor/culture_interceptor.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:core/utils/flow/MyFlow.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/common/user/UserSessionConst.dart';
import 'package:my_ios_app/presentation/translation.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/useCase/app/set_culture_use_case.dart';

class LanguagesUi extends StatelessWidget {
  const LanguagesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return MamakScaffold(
        body: Column(
      children: MamakTranslation.languages
          .map(
            (lang) => ListTile(
              title: Text(lang.getCountryName),
              leading: Checkbox(
                value: Get.locale == lang.locale(),
                onChanged: (value) async {
                  Get.locale = lang.locale();
                  print(lang.getCountryName);
                  print(lang.locale());
                  GetIt.I
                      .get<LocalSessionImpl>()
                      .insertData({UserSessionConst.lang: lang.getCountryName});
                  SetCultureUseCase().invoke(MyFlow(flow: (state) {}),
                      data: lang.getCountryCode);
                  GetIt.I
                      .get<CultureInterceptor>()
                      .setCulture(lang.getCountryCode);
                  Get.updateLocale(lang.locale());
                },
              ),
            ),
          )
          .toList(),
    ));
  }

  Future<bool> initInterceptors() async {
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<AuthorizationInterceptor>());
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<RefreshTokenInterceptor>());
    // RefreshTokenInterceptorUseCase().invoke();

    return Future.value(true);
  }
}
