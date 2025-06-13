import 'package:feature/languages/my_translation.dart';
import 'package:flutter/material.dart';

class Persian extends MyTranslation{
  @override
  String countryCode() => 'fa-IR';

  @override
  String countryName() => 'Persian';

  @override
  Locale locale() => const Locale('fa','IR');

}