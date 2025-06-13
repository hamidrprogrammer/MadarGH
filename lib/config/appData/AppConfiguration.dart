import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConfiguration {
  static const versionCode = 40;
  static const versionName = '96.5.1';
  static const packageName = 'ir.mamakschool.mamak';

  static bool enableNetworkLog = false;
  static bool cafeBazaar = true;
  static bool multiLanguage = true;
  static Locale? forceLocale = multiLanguage ? null : const Locale('fa', 'IR');

  get extraHeaders => {
        'version': versionCode.toString(),
        'platform': kIsWeb ? 'WebApp' : 'Android',
        if (!kIsWeb)
          'UserCheck':
              'yriIxwH46GccG9GmJT06rw+3wl7vvRFiEBnKcxWCkkCycLJMzUmeK//XUjecjZvc'
      };
}
