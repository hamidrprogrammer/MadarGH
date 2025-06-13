// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactUsBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsBody _$ContactUsBodyFromJson(Map<String, dynamic> json) =>
    ContactUsBody(

      message: json['question'] as String,
        contentCategoryId: json['contentCategoryId'] as int
    );

Map<String, dynamic> _$ContactUsBodyToJson(ContactUsBody instance) =>
    <String, dynamic>{

      'question': instance.message,
      'contentCategoryId':instance.contentCategoryId
    };
