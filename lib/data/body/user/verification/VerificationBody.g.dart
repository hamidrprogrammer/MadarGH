// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VerificationBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationBody _$VerificationBodyFromJson(Map<String, dynamic> json) =>
    VerificationBody(
      Username: json['Username'] as String,
      activationCode: json['activationCode'] as String,
    );

Map<String, dynamic> _$VerificationBodyToJson(VerificationBody instance) =>
    <String, dynamic>{
      'Username': instance.Username,
      'activationCode': instance.activationCode,
    };
