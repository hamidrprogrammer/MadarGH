// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePasswordBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordBody _$ChangePasswordBodyFromJson(Map<String, dynamic> json) =>
    ChangePasswordBody(
      CurrentPassword: json['CurrentPassword'],
      NewPassword: json['NewPassword'],
      ConfirmNewPassword: json['ConfirmNewPassword'],
    );

Map<String, dynamic> _$ChangePasswordBodyToJson(ChangePasswordBody instance) =>
    <String, dynamic>{
      'CurrentPassword': instance.CurrentPassword,
      'NewPassword': instance.NewPassword,
      'ConfirmNewPassword': instance.ConfirmNewPassword,
    };
