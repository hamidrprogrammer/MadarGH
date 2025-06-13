import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakLogo.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/PasswordFieldHelper.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/register/RegisterUi.dart';
import 'package:my_ios_app/presentation/viewModel/user/ChangePasswordViewModel.dart';

class ChangePasswordUi extends StatelessWidget {
  const ChangePasswordUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ChangePasswordViewModel(AppState.idle),
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
                  ),
                ),
                AppBar(
                  title: Text(
                    "change_password".tr,
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current password input
                buildPasswordInputField("previous_password".tr,
                    "previous_password".tr, bloc.onCurrentPasswordChange),
                SizedBox(height: 12),
                // New password input
                buildPasswordInputField("confirm_new_pas".tr,
                    "confirm_new_pas".tr, bloc.onPasswordChange),
                SizedBox(height: 12),
                // Confirm new password input
                buildPasswordInputField("confirm_password".tr,
                    "confirm_password".tr, bloc.onConfirmPasswordChange),
                SizedBox(height: 24),
                // Instruction
                Text(
                  "use_english_keyboard".tr,
                  style: TextStyle(
                    fontFamily: 'IRANSansXFaNum',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF505463),
                  ),
                ),
                SizedBox(height: 30),
                // Confirm button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                    onPressed: bloc.onSubmitClick,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(14.0),
                    ),
                    child: Center(
                      child: bloc.state.isLoading
                          ? const MyLoader(color: Colors.black)
                          : Text(
                              "submit".tr,
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
        );
      },
    );
  }

  Widget buildPasswordInputField(
      String title, String placeholder, Function(String) onChangeValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF353842),
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onChangeValue,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: TextStyle(
                      fontFamily: 'IRANSansXFaNum',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff505463),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
