import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';

class ForgetCodeValidation extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false, msg: 'enter_forgotten_code'.tr);
    }
    return const ValidationState(state: true);
  }
}
