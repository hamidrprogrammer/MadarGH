import 'package:core/recaptcha/android_recaptcha_solver.dart';
import 'package:core/recaptcha/web_recaptcha_solver.dart';
import 'package:flutter/foundation.dart';

abstract class RecaptchaSolver {
  static RecaptchaSolver factory() =>
      kIsWeb ? WebRecaptchaSolver() : AndroidRecaptchaSolver();

  Future<void> init();

  Future<String?> generateToken();
}
