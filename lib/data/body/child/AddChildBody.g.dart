// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddChildBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddChildBody _$AddChildBodyFromJson(Map<String, dynamic> json) => AddChildBody(
      childFirstName: json['childFirstName'] as String,
      childLastName: json['childLastName'] as String,
      birtDate: json['birtDate'] as String,
      userName: json['userName'] as String,
  gender: json['gender'] as int,

  childPicture: json['childPicture'] == null
          ? null
          : FileDataBody.fromJson(json['childPicture'] as Map<String, dynamic>),
    );
AddDateBody _$AddDatedBodyFromJson(Map<String, dynamic> json) => AddDateBody(
      executionDate: json['executionDate'] as String,
    );
Map<String, dynamic> _$AddDateBodyToJson(AddDateBody instance) =>
    <String, dynamic>{
      'executionDate': instance.executionDate,
    };
Map<String, dynamic> _$AddChildBodyToJson(AddChildBody instance) =>
    <String, dynamic>{
      'childFirstName': instance.childFirstName,
      'childLastName': instance.childLastName,
      'birtDate': instance.birtDate,
      'userName': instance.userName,
      'gender': instance.gender,

      'childPicture': instance.childPicture?.toJson(),
    };

EditChildBody _$EditChildBodyFromJson(Map<String, dynamic> json) =>
    EditChildBody(
      childFirstName: json['childFirstName'] as String,
      childLastName: json['childLastName'] as String,
      gender: json['gender'] as int,
      userChildId: json['userChildId'] as String,
      id: json['id'] as String,
      childPicture: json['childPicture'] == null
          ? null
          : FileDataBody.fromJson(json['childPicture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditChildBodyToJson(EditChildBody instance) =>
    <String, dynamic>{
      'childFirstName': instance.childFirstName,
      'childLastName': instance.childLastName,
      'userChildId': instance.userChildId,
      'id': instance.id,
      'gender': instance.gender,
      'avatar': instance.childPicture?.toJson(),
    };
