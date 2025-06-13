import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/ui/Information/InformationUi.dart';
import 'package:my_ios_app/presentation/ui/app/ShotViewrUi.dart';
import 'package:my_ios_app/presentation/ui/category/CategoryDetailUI.dart';
import 'package:my_ios_app/presentation/ui/child/AddChildUi.dart';
import 'package:my_ios_app/presentation/ui/child/EditChildPage.dart';
import 'package:my_ios_app/presentation/ui/child/MyChildrenScreen.dart';
import 'package:my_ios_app/presentation/ui/child/TransactionsScreen.dart';
import 'package:my_ios_app/presentation/ui/login/LoginUi.dart';
import 'package:my_ios_app/presentation/ui/more/languages_ui.dart';
import 'package:my_ios_app/presentation/ui/more/source_page.dart';
import 'package:my_ios_app/presentation/ui/newHome/new_home_ui.dart';
import 'package:my_ios_app/presentation/ui/package/PackageDetailUI.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/ui/root/MainPageUI.dart';
import 'package:my_ios_app/presentation/ui/splash/SplashUi.dart';
import 'package:my_ios_app/presentation/ui/subscription/SubscriptionUI.dart';
import 'package:my_ios_app/presentation/ui/user/ChangePasswordUi.dart';
import 'package:my_ios_app/presentation/ui/user/ForgetPasswordUi.dart';
import 'package:my_ios_app/presentation/ui/user/RecoveryPasswordUi.dart';
import 'package:my_ios_app/presentation/ui/user/VerificationUi.dart';
import 'package:my_ios_app/presentation/ui/user/VirfiyCodePassword.dart';
import 'package:my_ios_app/presentation/ui/user/profile/CalendarScreen.dart';
import 'package:my_ios_app/presentation/ui/user/profile/TmasNama.dart';
import 'package:my_ios_app/presentation/ui/workBook/WorkBookDetailUi.dart';
import 'package:my_ios_app/presentation/ui/workBook/WorkDetails.dart';
import 'package:my_ios_app/presentation/ui/workShop/AssessmentsUi.dart';

import 'AppRoute.dart';

class AppRouteHelper {
  static List<GetPage> router = [
    GetPage(
      name: AppRoute.login,
      page: () =>  const LoginUi(),
    ),
    GetPage(
      name: AppRoute.virfiyCodePassword,
      page: () => const VirfiyCodePassword(),
    ),
    GetPage(
      name: AppRoute.register,
      page: () =>  const RegisterUi(),
    ),
    GetPage(
      name: AppRoute.subscription,
      page: () =>  const SubscriptionUI(),
    ),
    GetPage(
      name: AppRoute.information,
      page: () =>  const InformationUi(),
    ),
    GetPage(
      name: AppRoute.home,
      page: () => const MainPageUI(),
    ),
    GetPage(
      name: AppRoute.root,
      page: () =>  const MainPageUI(),
    ),
    GetPage(
      name: AppRoute.splash,
      page: () => const SplashUi(), // Splash screen might not need layout
    ),
    GetPage(
      name: AppRoute.verification,
      page: () =>  const VerificationUi(),
    ),
    GetPage(
      name: AppRoute.packageDetail,
      page: () =>  const PackageDetailUI(),
    ),
    GetPage(
      name: AppRoute.forgetPassword,
      page: () =>  const ForgetPasswordUi(),
    ),
    GetPage(
      name: AppRoute.contactUsApp,
      page: () =>  const ContactUsApp(),
    ),
    GetPage(
      name: AppRoute.changePassword,
      page: () =>  const ChangePasswordUi(),
    ),
    GetPage(
      name: AppRoute.myChildren,
      page: () =>  const MyChildrenScreen()
    ),
    GetPage(
      name: AppRoute.eitChildPage,
      page: () =>  const EditChildPage()
    ),
    GetPage(
      name: AppRoute.calendarScreen,
      page: () =>  const CalendarScreen()
    ),
    GetPage(
      name: AppRoute.transactionsScreen,
      page: () =>  const TransactionsScreen()
    ),
    GetPage(
      name: AppRoute.recoveryPassword,
      page: () =>  const RecoveryPasswordUi()
    ),
    GetPage(
      name: AppRoute.workBookDetail,
      page: () =>  const WorkBookDetailUi()
    ),
    GetPage(
      name: AppRoute.assessments,
      page: () =>  const AssessmentsUi()
    ),
    GetPage(
      name: AppRoute.addChild,
      page: () =>  const AddChildUi()
    ),
    GetPage(
      name: AppRoute.workDetails,
      page: () =>  const WorkDetails()
    ),
    GetPage(
      name: AppRoute.categoryDetail,
      page: () =>  const CategoryDetailUI()
    ),
    GetPage(
      name: AppRoute.shotViewer,
      page: () =>  const ShotViewerUi()
    ),
    GetPage(
      name: AppRoute.newHome,
      page: () =>  const NewHomeUi()
    ),
    GetPage(
      name: AppRoute.sourceClick,
      page: () =>  const SourceUi()
    ),
    GetPage(
      name: AppRoute.languages,
      page: () =>  const LanguagesUi()
    ),
  ];
}

class BaseLayout extends StatelessWidget {
  final Widget child;

  BaseLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        return Center(
          child: Container(
            width: screenWidth < 600
                ? screenWidth // Mobile: full width
                : 414,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  textScaleFactor:
                      kIsWeb ? 1.1 : 1.2), // Adjust this value to scale text
              child: child!,
            ), // Use the provided screen content
          ),
        );
      },
    );
  }
}
