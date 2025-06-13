import 'package:feature/languages/my_translation.dart';
import 'package:flutter/material.dart';

class Germany extends MyTranslation{
  @override
  String countryCode() => 'de-DE';

  @override
  String countryName() => 'Germany';

  @override
  Locale locale() => const Locale('de','DE');
}