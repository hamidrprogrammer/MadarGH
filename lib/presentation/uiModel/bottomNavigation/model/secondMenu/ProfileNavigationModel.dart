import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class ProfileNavigationModel extends HomeNavigationModel {
  @override
  String badge() {
    return '';
  }

  @override
  Widget icon(color) {
    return SvgPicture.asset('assets/vectors/user.svg',
        width: 24, height: 24, color: color);
  }

  @override
  String name() {
    return 'profile'.tr;
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.Profile;
  }
}
