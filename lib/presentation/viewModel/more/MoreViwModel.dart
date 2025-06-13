import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/appData/AppConfiguration.dart';
import 'package:my_ios_app/presentation/uiModel/more/MoreItemModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class MoreViewModel extends BaseViewModel {
  late List<MoreItemModel> items;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  MoreViewModel(super.initialState) {
    defineItems();
  }

  void defineItems() {
    items = [
      MoreItemModel(
          iconData: CupertinoIcons.person_3_fill,
          name: 'add_child'.tr,
          onClick: addChildClick),
      MoreItemModel(
          iconData: Icons.password_sharp,
          name: 'change_password'.tr,
          onClick: changePasswordClick),
      // if(AppConfiguration.multiLanguage) MoreItemModel(
      //     iconData: Icons.language, name: 'languages'.tr, onClick: langsClick),
      MoreItemModel(
          iconData: CupertinoIcons.chart_pie,
          name: 'sources'.tr,
          onClick: sourceClick),
      MoreItemModel(
          iconData: CupertinoIcons.app_badge_fill,
          name: 'ویرایش اطلاعات',
          onClick: informationClick),
      MoreItemModel(
          iconData: Icons.logout, name: 'logout'.tr, onClick: logoutClick),
    ];
  }

  logoutClick() {
    session.clearSession();
    _navigationServiceImpl.replaceTo(AppRoute.login);
  }

  changePasswordClick() {
    _navigationServiceImpl.navigateTo(AppRoute.changePassword);
  }

  addChildClick() {
    _navigationServiceImpl.navigateTo(AppRoute.addChild);
  }

  sourceClick() {
    _navigationServiceImpl.navigateTo(AppRoute.sourceClick);
  }

  informationClick() {
    _navigationServiceImpl.navigateTo(AppRoute.information);
  }

  langsClick() {
    _navigationServiceImpl.navigateTo(AppRoute.languages)?.then((value) {
      defineItems();
      refresh();
    });
  }
}
