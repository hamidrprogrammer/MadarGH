import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';

class MoreNavigationModel extends HomeNavigationModel {
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
    return '';
  }

  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.ContactUs;
  }
}
