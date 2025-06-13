// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddSubscribeBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSubscribeBody _$AddSubscribeBodyFromJson(Map<String, dynamic> json) =>
    AddSubscribeBody(
      subscriptionId: json['subscriptionId'] as String,
      discountCode: json['discountCode'] as String,
    );

Map<String, dynamic> _$AddSubscribeBodyToJson(AddSubscribeBody instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'discountCode': instance.discountCode,
    };
