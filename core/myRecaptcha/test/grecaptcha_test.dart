import 'package:flutter_test/flutter_test.dart';
import 'package:my_recaptcha/grecaptcha.dart';
import 'package:my_recaptcha/grecaptcha_method_channel.dart';
import 'package:my_recaptcha/grecaptcha_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGrecaptchaPlatform with MockPlatformInterfaceMixin implements GrecaptchaPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  // TODO: implement isAvailable
  Future<bool> get isAvailable => throw UnimplementedError();

  @override
  Future<String> verifyWithRecaptcha(String siteKey) {
    // TODO: implement verifyWithRecaptcha
    throw UnimplementedError();
  }

  @override
  Future<GooglePlayServicesAvailability?> googlePlayServicesAvailability() {
    // TODO: implement googlePlayServicesAvailability
    throw UnimplementedError();
  }

  @override
  Future<String> init(String siteKey) {
    // TODO: implement init
    throw UnimplementedError();
  }
}

void main() {
  final GrecaptchaPlatform initialPlatform = GrecaptchaPlatform.instance;

  test('$MethodChannelGrecaptcha is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGrecaptcha>());
  });

  test('getPlatformVersion', () async {
    Grecaptcha grecaptchaPlugin = Grecaptcha();
    MockGrecaptchaPlatform fakePlatform = MockGrecaptchaPlatform();
    GrecaptchaPlatform.instance = fakePlatform;

    expect(await grecaptchaPlugin.getPlatformVersion(), '42');
  });
}
