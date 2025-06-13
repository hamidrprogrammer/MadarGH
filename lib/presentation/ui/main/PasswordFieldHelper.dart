import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/form/validator/PasswordValidator.dart';

class PasswordFieldHelper extends StatefulWidget {
  const PasswordFieldHelper(
      {Key? key, required this.onChangeValue, this.isRePsw = false})
      : super(key: key);
  final Function(String) onChangeValue;
  final bool isRePsw;

  @override
  State<PasswordFieldHelper> createState() => _PasswordFieldHelperState();
}

class _PasswordFieldHelperState extends State<PasswordFieldHelper> {
  bool obscureText = true;
  final RegExp _englishOnly = RegExp(r'^[a-zA-Z\s]*$');

  // Validator function to check if input contains only English characters

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text, // Specifies English keyboard
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@$%^&*.()_-\s]')),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(
          "${"usernameEn".tr}",
          style: TextStyle(
            fontSize: 12, // Set your desired font size here
              fontFamily: 'IRANSansXFaNum',
          ),
        ),
        hintText: 'password'.tr,
        prefixIcon: const Icon(CupertinoIcons.lock_fill),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          ),
        ),
      ),
      obscureText: obscureText,
      onChanged: widget.onChangeValue,
      validator: (value) =>
          PasswordValidator(widget.isRePsw).validate(value ?? '').msg,
    );
  }
}
