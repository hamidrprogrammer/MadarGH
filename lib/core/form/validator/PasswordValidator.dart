import 'package:get/get.dart';

import 'ValidationState.dart';
import 'Validator.dart';


class PasswordValidator extends Validator {
  final bool rePassword;

  PasswordValidator(this.rePassword);

  @override
  ValidationState validate(String data) {
    if (data.isEmpty) {
      return ValidationState(
          state: false,
          msg: rePassword
              ? 'enter_confirm_psw'.tr
              : 'enter_psw'.tr);
    }
    return const ValidationState(state: true);
  }
}
