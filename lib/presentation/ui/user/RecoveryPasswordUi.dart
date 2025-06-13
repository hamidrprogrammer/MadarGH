import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakLogo.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/viewModel/user/RecoveryPasswordViewModel.dart';

class RecoveryPasswordUi extends StatelessWidget {
  const RecoveryPasswordUi({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => RecoveryPasswordViewModel(AppState.idle),
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
                      "new_password".tr,
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
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: bloc.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    20.dpv,
                    buildInputField(
                      label: "new_password".tr,
                      hint: "new_password".tr,
                      onChangeValue: bloc.onPasswordChange,
                    ),
                    4.dpv,
                    buildInputField(
                      label: "confirm_new_pas".tr,
                      hint: "confirm_new_pas".tr,
                      onChangeValue: bloc.onConfirmPasswordChange,
                    ),
                    4.dpv,
                    20.dpv,
                    ElevatedButton(
                        onPressed: bloc.onSubmitClick,
                        child: bloc.state.isLoading
                            ? const MyLoader(color: Colors.black)
                            : Text('submit'.tr,
                                style: TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                )))
                  ],
                ),
              ),
            ));
      },
    );
  }
}
