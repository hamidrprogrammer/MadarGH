import 'package:get/get.dart';
import 'package:my_ios_app/core/form/validator/EmailValidator.dart';
import 'package:my_ios_app/core/form/validator/MobileValidator.dart';
import 'package:my_ios_app/core/form/validator/ValidationState.dart';
import 'package:my_ios_app/core/form/validator/Validator.dart';

class UserNameValidator extends Validator {
  @override
  ValidationState validate(String data) {
    if(data.isEmpty){
      return ValidationState(state: false, msg: 'empty_username'.tr);
    }
    if (data.isPhoneNumber) {
      return MobileValidator().validate(data);
    }
    if (data.isEmail) {
      return EmailValidator().validate(data);
    }
    return const ValidationState(state: true);
  }
}
