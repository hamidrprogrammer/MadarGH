// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EditChildDataBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditChildDataBody _$EditChildDataBodyFromJson(Map<String, dynamic> json) =>
    EditChildDataBody(
      childFirstName: json['childFirstName'] as String,
      childLastName: json['childLastName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      childPictureId: json['childPictureId'] as String,
      childPicture:
          FileDataBody.fromJson(json['childPicture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditChildDataBodyToJson(EditChildDataBody instance) =>
    <String, dynamic>{
      'childFirstName': instance.childFirstName,
      'childLastName': instance.childLastName,
      'mobileNumber': instance.mobileNumber,
      'childPictureId': instance.childPictureId,
      'childPicture': instance.childPicture.toJson(),
    };
