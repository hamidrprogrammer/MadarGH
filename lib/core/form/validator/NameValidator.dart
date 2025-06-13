import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';
class NameValidator extends Validator{
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_name'.tr);
    }
    return const ValidationState(state: true);
  }

}