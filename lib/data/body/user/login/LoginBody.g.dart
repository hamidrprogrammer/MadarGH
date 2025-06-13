// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) {
  String usernameInEnglish = _convertToEnglishNumberOrLeave(instance.username);

  return <String, dynamic>{
    'username': usernameInEnglish,
    'password': instance.password,
  };
}
String _convertToEnglishNumberOrLeave(String username) {
  // Check if the username is a number
  if (_isNumber(username)) {
    return _convertToEnglishNumber(username);
  } else {
    return username;
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