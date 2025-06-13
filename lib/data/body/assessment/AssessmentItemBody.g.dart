// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AssessmentItemBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentItemBody _$AssessmentItemBodyFromJson(Map<String, dynamic> json) =>
    AssessmentItemBody(
      assessmentQuestionId: json['assessmentQuestionId'] as String,
      assessmentQuestionOptionId: json['assessmentQuestionOptionId'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AssessmentItemBodyToJson(AssessmentItemBody instance) =>
    <String, dynamic>{
      'assessmentQuestionId': instance.assessmentQuestionId,
      'assessmentQuestionOptionId': instance.assessmentQuestionOptionId,
      'description': instance.description,
    };
