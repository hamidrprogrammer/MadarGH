import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class MyTranslation {
  String get path => "assets/lang/$getCountryCode/file.json";

  String countryName();

  String get getCountryName => countryName();

  String countryCode();

  Locale locale();

  String get getCountryCode => countryCode();

  Future<String> get getStringFromPath async => rootBundle.loadString(path);

  FutureOr<Map<String, String>> get getTranslation async =>
      Map.from(jsonDecode(await getStringFromPath));

}
