import 'package:flutter/cupertino.dart';
import 'package:my_ios_app/presentation/ui/Information/InformationUi.dart';
import 'package:my_ios_app/presentation/ui/Introduction/IntroductionUI.dart';
import 'package:my_ios_app/presentation/ui/contactUs/ContactUsUi.dart';
import 'package:my_ios_app/presentation/ui/more/MoreNewUi.dart';
import 'package:my_ios_app/presentation/ui/newHome/new_home_ui.dart';
import 'package:my_ios_app/presentation/ui/subscription/SubscriptionUI.dart';
import 'package:my_ios_app/presentation/ui/user/profile/ProfileUi.dart';
import 'package:my_ios_app/presentation/ui/workBook/WorkBookUi.dart';
import 'package:my_ios_app/presentation/ui/workShop/MyWorkShops.dart';

abstract class HomeNavigationModel {
  String name();

  String badge();

  String get getName => name();

  String get getBadge => badge();

  Widget icon(color);

  HomeNavigationEnum value();

  Widget getIcon(Color color) =>
      icon(color); // This directly returns the widget

  int get index => value().value;
}

enum HomeNavigationEnum {
  Home(3),

  Workbook(4),
  WorkShops(9),
  Profile(11),
  Subscription(0),
  Introduction(1),
  // More(2),

  SecondMore(5),
  ContactUs(6),
  Setting(7),

  Estimate(10),

  Information(12);

  final int value;

  const HomeNavigationEnum(this.value);
}

extension HomeNavigationExtension on int {
  HomeNavigationEnum toHomeNavigationEnum() {
    switch (this) {
      // case 0:
      //   return HomeNavigationEnum.Subscription;
      // case 1:
      //   return HomeNavigationEnum.Introduction;
      // case 2:
      //   return HomeNavigationEnum.More;
      case 3:
        return HomeNavigationEnum.Home;
      case 4:
        return HomeNavigationEnum.Workbook;
      // case 5:
      //   return HomeNavigationEnum.SecondMore;
      // case 6:
      //   return HomeNavigationEnum.ContactUs;
      case 11:
        return HomeNavigationEnum.Profile;
      case 12:
      // return HomeNavigationEnum.Information;
      case 9:
        return HomeNavigationEnum.WorkShops;
      default:
        return HomeNavigationEnum.Home;
    }
  }
}

extension HomeNavigationEnumExtension on HomeNavigationEnum {
  Widget getPage() {
    switch (this) {
      // case HomeNavigationEnum.Subscription:
      // return const SubscriptionUI();
      // case HomeNavigationEnum.Introduction:
      // return const IntroductionUI();
      // case HomeNavigationEnum.More:
      // return const SizedBox.shrink();
      case HomeNavigationEnum.Home:
        return const NewHomeUi();
      case HomeNavigationEnum.Workbook:
        return const WorkBookUi();
      case HomeNavigationEnum.Profile:
        return const ProfileUi();
      case HomeNavigationEnum.WorkShops:
        return const MyWorkShops();
      // case HomeNavigationEnum.ContactUs:
      // return const ContactUsUi();

      // case HomeNavigationEnum.Information:
      // return const InformationUi();
      // case HomeNavigationEnum.SecondMore:
      // return const MoreHomeNewUi();
      default:
        return const SizedBox.shrink();
    }
  }
}
