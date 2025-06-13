import 'package:core/recaptcha/recaptcha_common.dart';
import 'package:core/recaptcha/recaptcha_solver.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart'; //--1

class WebRecaptchaSolver extends RecaptchaSolver {

  WebRecaptchaSolver(){
  initReCaptcha();
  }

  void initReCaptcha() async {
    await init();
    await GRecaptchaV3.hideBadge();
  }
  @override
  Future<void> init() async {
    bool ready = await GRecaptchaV3.ready(RecaptchaCommon.siteKey); //--2
    Logger.d("Is Recaptcha ready? $ready");
  }

  @override
  Future<String?> generateToken() {
    return GRecaptchaV3.execute(RecaptchaCommon.actionName);
  }
}
