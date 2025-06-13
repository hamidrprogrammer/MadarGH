import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';

class EmailValidator extends Validator {
  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(state: false, msg: 'enter_email'.tr);
    }
    if (!emailValid(data)) {
      return ValidationState(
          state: false, msg: 'invalid_email'.tr);
    }

    return const ValidationState(state: true);
  }

  bool emailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
