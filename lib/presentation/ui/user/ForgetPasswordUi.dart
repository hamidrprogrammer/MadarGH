import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/appData/locales/AppDefaultLocale.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/core/form/validator/MobileValidator.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/TextFormFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/ForgetPasswordViewModel.dart';

class ForgetPasswordUi extends StatelessWidget {
  const ForgetPasswordUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ForgetPasswordViewModel(AppState.idle),
      builder: (bloc, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Stack(
              children: [
                Positioned.fill(
                  top: kIsWeb ? 0 : 15,
                  child: Image.asset(
                    'assets/Rectangle21.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                AppBar(
                  title: Text(
                    "فراموشی رمز عبور",
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ],
            ),
          ),
          body: Directionality(
            textDirection: AppDefaultLocale.getAppLocale.toString() == "en_US"
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12),
                  buildInputField(
                    label: "enter_username".tr,
                    hint: "email_or_mobile".tr,
                    onChangeValue: bloc.onMobileChange,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "use_english_keyboard".tr,
                    style: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF5F6286),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ElevatedButton(
                      onPressed: bloc.sendCode.call(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(319, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: Center(
                        child: bloc.state.isLoading
                            ? const MyLoader()
                            : Text(
                                "send_code".tr,
                                style: TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
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
      required Function(String) onChangeValue}) {
    final TextStyle inputLabelStyle = TextStyle(
      fontFamily: 'IRANSansXFaNum',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.7,
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
