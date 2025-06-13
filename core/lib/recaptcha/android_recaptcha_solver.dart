import 'package:core/recaptcha/recaptcha_common.dart';
import 'package:core/recaptcha/recaptcha_solver.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:my_recaptcha/grecaptcha.dart';

class AndroidRecaptchaSolver extends RecaptchaSolver {

  final Grecaptcha grecaptcha = Grecaptcha();

  AndroidRecaptchaSolver(){
    init();
  }
  @override
  Future<String> generateToken() {
    return grecaptcha.verifyWithRecaptcha(RecaptchaCommon.actionName);
  }

  @override
  Future<void> init() async {
    Logger.d('initializing grecaptcha');
    await grecaptcha.init(RecaptchaCommon.siteKeyAndroid);
  }
}
