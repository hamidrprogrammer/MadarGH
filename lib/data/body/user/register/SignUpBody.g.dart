// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUpBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpBody _$SignUpBodyFromJson(Map<String, dynamic> json) => SignUpBody(
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'] as String?,
      ReCaptchaToken: json['ReCaptchaToken'] as String?,
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      email: json['email'],
    );

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  String mobileInEnglish = instance.mobile != null
      ? _convertToEnglishNumberOrLeave(instance.mobile!)
      : "";

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('password', instance.password);
  writeNotNull('confirmPassword', instance.confirmPassword);
  writeNotNull('mobile', mobileInEnglish);
  writeNotNull('ReCaptchaToken', instance.ReCaptchaToken);
  return val;
}

String _convertToEnglishNumberOrLeave(String numberString) {
  // Check if the numberString is a number
  if (_isNumber(numberString)) {
    return _convertToEnglishNumber(numberString);
  } else {
    return numberString;
  }
}

bool _isNumber(String input) {
  // Use a regular expression to check if the input consists only of digits
  final RegExp isNumberRegex = RegExp(r'^[0-9]+$');
  return isNumberRegex.hasMatch(input);
}

String _convertToEnglishNumber(String numberString) {
  Map<String, String> persianToEnglishNumberMap = {
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9'
  };

  String numberInEnglish = '';
  for (int i = 0; i < numberString.length; i++) {
    if (persianToEnglishNumberMap.containsKey(numberString[i])) {
      numberInEnglish += persianToEnglishNumberMap[numberString[i]]!;
    } else {
      numberInEnglish += numberString[i];
    }
  }
  return numberInEnglish;
}
