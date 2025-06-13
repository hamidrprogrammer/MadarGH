// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecoveryPasswordBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoveryPasswordBody _$RecoveryPasswordBodyFromJson(
        Map<String, dynamic> json) =>
    RecoveryPasswordBody(
      username: json['username'] as String,
      activationCode: json['activationCode'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$RecoveryPasswordBodyToJson(
        RecoveryPasswordBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'activationCode': instance.activationCode,
    };
