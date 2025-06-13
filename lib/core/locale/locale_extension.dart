import 'dart:ui';

import 'package:get/get.dart';

extension LocaleExtension on Locale? {
  bool get isPersian => Get.locale == const Locale('fa', 'IR');
}
