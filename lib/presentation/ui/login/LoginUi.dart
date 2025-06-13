import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/appData/locales/AppDefaultLocale.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/core/form/validator/EmailValidator.dart';
import 'package:my_ios_app/core/form/validator/MobileValidator.dart';
import 'package:my_ios_app/core/form/validator/username_validator.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakLogo.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/user/LoginViewModel.dart';
import 'package:my_ios_app/utils.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle inputLabelStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.7, // This matches the 16px line height
      color: Color(0xFF353842),
    );

    final TextStyle inputHintStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.7,
      color: Color(0xFF505463),
    );

    final TextStyle hintStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 2, // This matches the 24px line height
      color: Color(0xFF5F6286),
    );

    final TextStyle buttonTextStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.5, // This matches the 24px line height
      color: Colors.white,
    );

    final TextStyle linkTextStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w600,
      fontSize: 12,
      height: 2, // This matches the 24px line height
      color: Color(0xFF9E3840),
    );
    return CubitProvider(
      create: (context) => LoginViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Stack(
              children: [
                Positioned.fill(
                  top: kIsWeb ? 0 : 15,
                  child: Image.asset(
                    'assets/Rectangle21.png', // Path to your SVG file
                    fit: BoxFit.fitWidth,
                    // To cover the entire AppBar
                  ),
                ),
                AppBar(
                  title: Text(
                    "login".tr,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor:
                      Colors.transparent, // Make AppBar transparent
                  elevation: 0, // Remove shadow
                ),
              ],
            ),
          ),
          body: Directionality(
            textDirection: AppDefaultLocale.getAppLocale.toString() == "en_US"
                ? TextDirection.ltr
                : TextDirection.rtl, // Set RTL direction
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "login".tr,
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    buildInputField(
                        label: 'username_hint'.tr,
                        hint: 'email_or_phone_hint'.tr,
                        obscureText: false,
                        onChangeValue: bloc.onMobileChange),
                    SizedBox(height: 20),
                    buildInputField(
                        label: 'password'.tr,
                        hint: 'password_hint'.tr,
                        obscureText: true,
                        onChangeValue: bloc.onPasswordChange),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'use_english_keyboard'.tr,
                        style: hintStyle,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Aligns the child to the right
                        children: [
                          TextButton(
                            onPressed: bloc.pushToForgetPassword.call(),
                            child: Text(
                              'forgot_password'.tr,
                              style:
                                  linkTextStyle, // Replace with your actual text style
                            ),
                          ),
                        ]),
                    SizedBox(height: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF9E3840),
                        minimumSize: Size(319, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      ),
                      onPressed: bloc.loginUser.call(),
                      child: bloc.state.isLoading
                          ? const MyLoader(color: Colors.black)
                          : Text(
                              'confirm_and_continue'.tr,
                              style: buttonTextStyle,
                            ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      ),
                      onPressed: bloc.gotoSignUpPage.call(),
                      child: Text(
                        'create_new_account'.tr,
                        style: linkTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildInputField(
      {required String label,
      required String hint,
      required bool obscureText,
      required Function(String) onChangeValue}) {
    final TextStyle inputLabelStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.7, // This matches the 16px line height
      color: Color(0xFF353842),
    );
    final TextStyle inputHintStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.7,
      color: Color(0xFF505463),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: inputLabelStyle,
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: onChangeValue,
            textDirection: TextDirection.rtl,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: inputHintStyle,
            ),
          ),
        ),
      ],
    );
  }
}
