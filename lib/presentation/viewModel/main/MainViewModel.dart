import 'dart:math';

import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';
import 'package:my_ios_app/presentation/ui/dialog/AddChildDialog.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/SubscriptionNavigationModel.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/object/BottomNavigationObject.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/GetRemainingDayUseCase.dart';

class MainViewModel extends BaseViewModel implements MyNotificationListener {
  AnimationController? animationController;
  var showSecondMenu = false;
  var fake = "0";

  final homeMenu = BottomNavigationObject.homeMenu;
  // final secondHomeMenu = BottomNavigationObject.secondHomeMenu;
  var _index = HomeNavigationEnum.Home.value;
  final MyNotification _notification = GetIt.I.get();

  int get currentValue => _index;

  List<HomeNavigationModel> get totalMenu => homeMenu;

  MainViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getRemainingDay();
    getChildOfUser();
  }

  Function(int) onIndexChange() {
    return (value) {
      var item = totalMenu
          .firstWhereOrNull((element) => element.value().value == value);
      if (item != null) {
        if (item is MoreNavigationModel) {
          onChangeSecondMenuState();
        } else {
          // if (item is SubscriptionNavigationModel) {
          //   if ((item).getBadge != '') {
          //     messageService.showSnackBar(
          //         '${item.getBadge} روز از اشتراک شما باقی مانده است');
          //     //can show message here
          //     return;
          //   }
          // }
          _index = item.value().value;
          updateScreen(time: value.toDouble());
        }
      }
    };
  }

  void onChangeSecondMenuState() {
    showSecondMenu = !showSecondMenu;
    if (showSecondMenu) {
      print("showSecondMenu");

      animationController?.reverse(from: 0.5);
    } else {
      animationController?.forward(from: 0.0);
    }
    refreshScreen();
  }

  void updateRemainingDay(String value) {
    var index = homeMenu.indexWhere((element) =>
        element.value().index == HomeNavigationEnum.Subscription.value);
    fake = value;
    print("fake==============>" + fake);
    refreshScreen();
    refresh();

    (homeMenu[index] as SubscriptionNavigationModel).changeBadge(value);
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  @override
  void onReceiveData(data) {
    if (data != null) {
      if (data is int) {
        //change index of bottom navigation
        int index = data;
        onIndexChange().call(index);
      } else if (data is String) {
        //Change subscription badge
        _index = 3;
        updateScreen(time: 3);
      }
    }
  }

  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isFailed) {
        if (appState.getErrorModel?.state == ErrorState.Empty) {
          Get.dialog(const AddChildDialog());
        }
      }
    }));
  }

  void getRemainingDay() {
    GetRemainingDayUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        String count = appState.getData.toString();
        // GetIt.I.get<MyNotification>().publish('MainViewModel', count);
      }
    }));
  }

  @override
  String tag() {
    return 'MainViewModel';
  }

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
}
