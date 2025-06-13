

import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';

class NationalCodeValidator extends Validator{
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_national_code'.tr);
    }
    if (data.length < 10) {
      return ValidationState(
          state: false, msg: 'national_code_less'.tr);
    }
    if (data.length > 11) {
      return ValidationState(
          state: false, msg: 'invalid_national_code'.tr);
    }
    return const ValidationState(state: true);
  }

}