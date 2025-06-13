import 'package:get/get.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';

import 'ValidationState.dart';
import 'Validator.dart';

import 'package:flutter/widgets.dart';


class MobileValidator extends Validator {
  bool isPersianNumber(String input) {
    // Regular expression to match Persian numbers
    RegExp persianNumbers = RegExp(r'^[\u06F0-\u06F9]+$');
    return persianNumbers.hasMatch(input);
  }

  String convertToEnglishNumber(String farsiNumber) {
    // Maps for converting Persian numbers to English numbers
    Map<String, String> persianToEnglish = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    String englishNumber = '';
    for (int i = 0; i < farsiNumber.length; i++) {
      if (persianToEnglish.containsKey(farsiNumber[i])) {
        englishNumber += persianToEnglish[farsiNumber[i]]!;
      } else {
        englishNumber += farsiNumber[i];
      }
    }
    return englishNumber;
  }
  @override
  ValidationState validate(String data) {
    String englishNumber = '';
    if (isPersianNumber(data)) {
      englishNumber = convertToEnglishNumber(data);
    } else {
      englishNumber = data;
    }
    if (englishNumber.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_mobile'.tr);
    }
    if(!Get.locale.isPersian){
      return const ValidationState(state: true);
    }
    if (englishNumber.length < 11) {
      return const ValidationState(
          state: false, msg: 'شماره موبایل وارد شده کمتر از ۱۱ رقم است');
    }

    return const ValidationState(state: true);
  }

  static TextInputType mobileInputType = TextInputType.phone;
}
