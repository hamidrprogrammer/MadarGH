// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserCustomCalendarBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCustomCalendarBody _$UserCustomCalendarBodyFromJson(
        Map<String, dynamic> json) =>
    UserCustomCalendarBody(
      userChildId: json['userChildId'] as String,
      packageId: json['packageId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CustomCalendarItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserCustomCalendarBodyToJson(
        UserCustomCalendarBody instance) =>
    <String, dynamic>{
      'userChildId': instance.userChildId,
      'packageId': instance.packageId,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
