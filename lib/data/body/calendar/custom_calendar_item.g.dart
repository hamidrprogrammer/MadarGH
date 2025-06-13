// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_calendar_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomCalendarItem _$CustomCalendarItemFromJson(Map<String, dynamic> json) =>
    CustomCalendarItem(
      parentCategoryId: json['parentCategoryId'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
    );

Map<String, dynamic> _$CustomCalendarItemToJson(CustomCalendarItem instance) =>
    <String, dynamic>{
      'parentCategoryId': instance.parentCategoryId,
      'dayOfWeek': instance.dayOfWeek,
    };
