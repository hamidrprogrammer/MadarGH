
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_ios_app/core/form/validator/Validator.dart';

class TextFormFieldHelper extends StatelessWidget {
  const TextFormFieldHelper({
    Key? key,
    required this.label,
    required this.hint,
    this.icon,
    this.helperText,
    required this.keyboardType,
    required this.onChangeValue,
    this.onCompleted,
    this.validator,
    this.maxLength,
    this.initValue,
    this.maxLine,
    this.minLine,
    this.textAlign = TextAlign.start,
    this.expand = false,
    this.onTap,
    this.controller,
    this.textInputAction,
    this.inputFormatters,
    
    this.labelStyle,
  }) : super(key: key);
  final String label;
  final String? initValue;
  final String hint;
  final String? helperText;
  final IconData? icon;
  final Validator? validator;
  final TextInputType keyboardType;
   final List<FilteringTextInputFormatter>? inputFormatters;
  final Function(String) onChangeValue;
  final Function()? onCompleted;
  final int? maxLength;
  final int? maxLine;
  final int? minLine;
  final TextAlign textAlign;
  final bool expand;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      onTap: onTap,
      textAlign: textAlign,
      initialValue: initValue,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(label,textAlign: TextAlign.start),
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        labelStyle: labelStyle,
        helperText: helperText
      ),
      maxLength: maxLength,
      validator: (value) => validator?.validate(value ?? '').msg,
      keyboardType: keyboardType,
      onChanged: onChangeValue,
      expands: expand,
      maxLines: maxLine,
      minLines: minLine,
      inputFormatters:inputFormatters,
      textAlignVertical: TextAlignVertical.top,
      style: labelStyle,
      onEditingComplete: onCompleted,
    );
  }
}
