import 'dart:convert';

import 'package:core/Notification/MyNotification.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:feature/jwt/jwt_generator.dart';
import 'package:feature/poolakey/inapp_purchase_info.dart';
import 'package:feature/poolakey/poolakey_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/appData/AppConfiguration.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';
import 'package:my_ios_app/core/network/errorHandler/common/ErrorMessages.dart';
import 'package:my_ios_app/data/body/subscribe/AddSubscribeBody.dart';
import 'package:my_ios_app/data/body/subscribe/DiscountCodeBody.dart';
import 'package:my_ios_app/data/serializer/subscribe/AllSubscriptionResponse.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/payment/PayOrderUseCase.dart';
import 'package:my_ios_app/useCase/payment/payOrderResultByCafeBazaarUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/AddSubscribeUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/CurrentPackageUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/DiscountCodeUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/GetAllSubscriptionsUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/GetRemainingDayUseCase.dart';
// import 'package:uni_links/uni_links.dart';

class SubscriptionViewModel extends BaseViewModel with WidgetsBindingObserver {
  AppState uiState = AppState.idle;
  AppState adSubscribeState = AppState.idle;
  AppState discountCodeState = AppState.idle;
  AppState mySubscriptionState = AppState.idle;
  AllSubscriptionItem? selectedItem;
  String? dynamicPriceToken;

  String? dynamicOrderId;

  final bool cafeBazaar = AppConfiguration.cafeBazaar;

  final TextEditingController codeController = TextEditingController();

  final MyNotification _notification = GetIt.I.get();
  final PoolakeyHelper? _poolakeyHelper = kIsWeb ? null : GetIt.I.get();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  SubscriptionViewModel(super.initialState) {
    WidgetsBinding.instance.addObserver(this);

    getCurrentSubscription();
    getSubscriptions();
  }

  void getSubscriptions() {
    GetAllSubscriptionsUseCase().invoke(MyFlow(flow: (appState) {
      // if (appState.isSuccess) {
      //   if (appState.getData is List<AllSubscriptionItem>) {
      //     List<AllSubscriptionItem> child = appState.getData;
      //     if (child.isNotEmpty) {
      //       selectedItem = child.first;
      //     }
      //   }
      // }
      uiState = appState;
      refresh();
    }));
  }

  onChangeSelectedItem(AllSubscriptionItem? newSelected) {
    if (newSelected != null) {
      selectedItem = newSelected;
      dynamicPriceToken = null;
      refresh();
    }
  }

  void getCurrentSubscription() {
    CurrentPackageUseCase().invoke(MyFlow(flow: (appState) {
      // if(appState.isFailed){
      //   if (selectedItem == null) {
      //     getSubscriptions();
      //   }
      // }
      mySubscriptionState = appState;
      refresh();
    }));
  }

  void checkDiscountCode() {
    if (selectedItem != null && codeController.text.isNotEmpty) {
      DiscountCodeBody body = DiscountCodeBody(
          amount: selectedItem?.price?.toString() ?? '',
          code: codeController.text);

      DiscountCodeUseCase().invoke(MyFlow(flow: (appState) async {
        if (appState.isSuccess) {
          selectedItem?.discount = int.tryParse(appState.getData) ?? 0;
          dynamicPriceToken = await JwtGenerator().generateToken(
              pId: selectedItem?.cafeBazaarIdentity ?? '',
              price: selectedItem?.discount ?? 0);
        }
        if (appState.isFailed) {
          selectedItem?.discount = null;

          dynamicPriceToken = null;
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        discountCodeState = appState;
        refresh();
      }), data: body);
    }
  }

  void getRemainingDay() {
    GetIt.I.get<MyNotification>().publish('MainViewModel', "0");
  }

  void onChangeCode(String newCode) {
    codeController.text = newCode; // Set the new code
    refresh(); //
  }

  void submitCode() {
    if (selectedItem == null) {
      messageService.showSnackBar('select_subscription'.tr);
      return;
    }

    if (codeController.text.isEmpty || codeController.text.length < 4) {
      messageService.showSnackBar('enter_discount_code'.tr);
      return;
    }

    checkDiscountCode();
  }

  void submitSubscribe() async {
    if (selectedItem == null) {
      messageService.showSnackBar('select_subscription'.tr);
      return;
    }

    AddSubscribeBody body = AddSubscribeBody(
      subscriptionId: selectedItem?.id?.toString() ?? '',
      discountCode: codeController.text,
    );
    AddSubscribeUseCase().invoke(
      MyFlow(flow: (appState) async {
        if (appState.isFailed) {
          messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        }
        if (appState.isSuccess) {
          var response = appState.getData;
          dynamicOrderId = response?.id?.toString();
          print(response?.id?.toString());
          if(kIsWeb){
               payOrder();
               return;
          }
       if(!kIsWeb) {
         try {
         

           payOrder();

           messageService.showSnackBar('pay_was_success'.tr);
           _navigationServiceImpl.pop();
           // if (res?.state == InAppPurchaseState.success) {
           // } else {}
         } catch (e) {
           messageService.showSnackBar('payment_fail'.tr);
           adSubscribeState = appState;
           refresh();
         }
       }

        } else {
          adSubscribeState = appState;
          refresh();
        }
      }),
      data: body,
    );
  }

  void payOrder() {
    PayOrderUseCase().invoke(MyFlow(flow: (appState) {
      print(appState.isFailed.toString());
      print(appState.getErrorModel?.state.toString());
      print(ErrorState.SuccessMsg.toString());

        if (!kIsWeb) {
          payOrderCafeBazaar();
          getRemainingDay();
        }

      if (appState.isSuccess && kIsWeb) {
        Logger.d('success');
       
        _launchUrl(appState.getData);
         getRemainingDay();
      }
      if (appState.isFailed) {
        Logger.d('failed');
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
        if (appState.getErrorModel?.state == ErrorState.SuccessMsg) {
          _notification.publish(
            'MainViewModel',
            HomeNavigationEnum.WorkShops.value,
          );
        }
      }
      adSubscribeState = appState;
      refresh();
    }), data: kIsWeb);
  }

  payOrderCafeBazaar() {
    PayOrderResultByCafeBazaarUseCase().invoke(MyFlow(flow: (resultState) {
      if (resultState.isFailed) {
        print(
            'result PayOrderResultByCafeBazaarUseCase is ${resultState.getErrorModel?.message}');
      } else {
        print('result PayOrderResultByCafeBazaarUseCase is $resultState');
      }
      adSubscribeState = resultState;
      refresh();
    }),
        data: selectedItem?.discount ?? selectedItem?.price,
        orderId: dynamicOrderId);
  }

  Future<void> _launchUrl(String url) async {
    // if (!await launchUrl(Uri.parse(url),
    //     mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch $url');
    // }
  }

  String getPaymentResultBuStatusCode(int? statusCode) {
    switch (statusCode) {
      case -1:
        return "اطلاعات ارسالی ناقص است.";
      case -3:
        return "ﺑﺎ ﺗﻮﺟﻪ ﺑﻪ ﻣﺤﺪﻭﺩﻳﺖ ﻫﺎﻱ ﺷﺎﭘﺮﻙ ﺍﻣﻜﺎﻥ ﭘﺮﺩﺍﺧﺖ ﺑﺎ ﺭﻗﻢ ﺩﺭﺧﻮﺍﺳﺖ ﺷﺪﻩ ممکن ﻧﻤﻲ ﺑﺎﺷﺪ.";
      case -11:
        return "ﺩﺭﺧﻮﺍﺳﺖ ﻣﻮﺭﺩ ﻧﻈﺮ ﻳﺎﻓﺖ ﻧﺸﺪ.";
      case -21:
        return "ﻫﻴﭻ ﻧﻮﻉ ﻋﻤﻠﻴﺎﺕ ﻣﺎﻟﻲ ﺑﺮﺍﻱ ﺍﻳﻦ ﺗﺮﺍﻛﻨﺶ ﻳﺎﻓﺖ ﻧﺸﺪ.";
      case -22:
        return "ﺗﺮﺍﻛﻨﺶ ﻧﺎﻣﻮﻓﻖ می باشد.";
      case -33:
        return "ﺭﻗﻢ ﺗﺮﺍﻛﻨﺶ ﺑﺎ ﺭﻗﻢ ﭘﺮﺩﺍﺧﺖ ﺷﺪﻩ ﻣﻄﺎﺑﻘﺖ ندارد.";
      case 101:
        return "عملیات پرداخت قبلاً صورت گرفته است.";
      default:
        return ErrorMessages().ErrorMessage_Connection;
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkForDeepLink();
    }
    super.didChangeAppLifecycleState(state);
  }

  void checkForDeepLink() async {
    // var data = await getInitialUri();
    // if (data != null) {
    //   var result = data.queryParameters['success']?.toString();
    //   if (result != null) {
    //     if (result == "400") {
    //       messageService.showSnackBar('payment_fail'.tr);
    //     } else if (result == "200") {
    //       getRemainingDay();
    //       _notification.publish(
    //           'MainViewModel', HomeNavigationEnum.WorkShops.value);
    //       messageService.showSnackBar('paymane_success'.tr);
    //     }
    //   }
    // }
  }
}
