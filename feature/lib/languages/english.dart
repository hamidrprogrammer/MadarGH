import 'dart:ui';

import 'package:feature/languages/my_translation.dart';

class English extends MyTranslation {
  @override
  String countryCode() => 'en-US';

  @override
  String countryName() => 'English';

  @override
  Locale locale() => const Locale('en','US');
}
