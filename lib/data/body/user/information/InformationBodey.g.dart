// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

part of 'InformationBodey.dart';

InformationBody _$InformationBodyFromJson(Map<String, dynamic> json) =>
    InformationBody(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
      motherEducation: json['motherEducation'],
      motherJobTitle: json['motherJobTitle'],
      motherJobStatus: json['motherJobStatus'],
      fatherEducation: json['fatherEducation'],
      fatherJobTitle: json['fatherJobTitle'],
      fatherJobStatus: json['fatherJobStatus'],
      maritalStatus: json['maritalStatus'],
      mentalPeace: json['mentalPeace'],
      support: json['support'],
      health: json['health'],
    );

Map<String, dynamic> _$InformationBodyToJson(InformationBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('motherEducation', instance.motherEducation);
  writeNotNull('motherJobTitle', instance.motherJobTitle);
  writeNotNull('motherJobStatus', instance.motherJobStatus);
  writeNotNull('fatherEducation', instance.fatherEducation);
  writeNotNull('fatherJobTitle', instance.fatherJobTitle);
  writeNotNull('fatherJobStatus', instance.fatherJobStatus);
  writeNotNull('fatherJobStatus', instance.fatherJobStatus);
  writeNotNull('maritalStatus', instance.maritalStatus);
  writeNotNull('mentalPeace', instance.mentalPeace);
  writeNotNull('mentalPeace', instance.mentalPeace);
  writeNotNull('support', instance.support);
  writeNotNull('health', instance.health);
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
