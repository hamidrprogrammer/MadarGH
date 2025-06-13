import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/appData/appTheme/MyTheme.dart';

import '../../uiCommon/WidgetSize.dart';

class AppTheme {
  static ThemeData myTheme() {
    return ThemeData(
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: Colors.white,
        collapsedTextColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        iconColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.black,
              fontFamily:
                  Get.locale == const Locale('fa', 'IR') ? 'yekan' : null,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: MyTheme.color,
      ),
      // scaffoldBackgroundColor: ViewConsts.backGroundColor,
      scaffoldBackgroundColor: MyTheme.backGroundColor,
      useMaterial3: false,
      primaryColorDark: MyTheme.color,
      fontFamily: Get.locale == const Locale('fa', 'IR') ? 'dana' : null,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.5),
      brightness: Brightness.light,
      primaryColor: MyTheme.color,
      inputDecorationTheme: InputDecorationTheme(
        focusColor: MyTheme.color,
        contentPadding: const EdgeInsets.all(8.0),
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(WidgetSize.textFieldRadiusSize),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.color, width: 2.0),
          borderRadius: BorderRadius.circular(WidgetSize.textFieldRadiusSize),
        ),
        fillColor: Colors.grey.shade50,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(WidgetSize.elevatedButtonRadiusSize),
                side: BorderSide(color: Color(0xFF9E3840))),
            backgroundColor: MyTheme.color,
            foregroundColor: Colors.black,
            padding:
                const EdgeInsets.all(WidgetSize.elevatedButtonPaddingSize)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: TextStyle(
              color: Colors.white,
              fontFamily:
                  Get.locale == const Locale('fa', 'IR') ? 'dana' : null,
              fontWeight: FontWeight.bold),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: MyTheme.color),
    );
  }
}
