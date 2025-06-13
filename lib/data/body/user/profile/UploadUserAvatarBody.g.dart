// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadUserAvatarBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadUserAvatarBody _$UploadUserAvatarBodyFromJson(
        Map<String, dynamic> json) =>
    UploadUserAvatarBody(
      mobileNumber: json['mobileNumber'] as String,
      fileData: FileDataBody.fromJson(json['fileData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadUserAvatarBodyToJson(
        UploadUserAvatarBody instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'fileData': instance.fileData.toJson(),
    };
