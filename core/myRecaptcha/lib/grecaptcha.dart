import 'grecaptcha_platform_interface.dart';

class Grecaptcha {
  Future<String?> getPlatformVersion() {
    return GrecaptchaPlatform.instance.getPlatformVersion();
  }

  Future<bool> get isAvailable {
    return GrecaptchaPlatform.instance.isAvailable;
  }

  Future<String> verifyWithRecaptcha(String action) {
    return GrecaptchaPlatform.instance.verifyWithRecaptcha(action);
  }

  Future<void> init(String siteKey) {
    return GrecaptchaPlatform.instance.init(siteKey);
  }

  Future<GooglePlayServicesAvailability?> googlePlayServicesAvailability() {
    return GrecaptchaPlatform.instance.googlePlayServicesAvailability();
  }
}
