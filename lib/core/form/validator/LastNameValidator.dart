import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';
class LastNameValidator extends Validator{
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_last_name'.tr);
    }
    return const ValidationState(state: true);
  }

}