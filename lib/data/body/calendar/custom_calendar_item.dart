import 'package:json_annotation/json_annotation.dart';

part 'custom_calendar_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomCalendarItem {
  final String parentCategoryId, dayOfWeek;

  CustomCalendarItem({
    required this.parentCategoryId,
    required this.dayOfWeek,
  });

  Map<String, dynamic> toJson() =>
      _$CustomCalendarItemToJson(this);

  static CustomCalendarItem fromJson(Map<String, dynamic> json) =>
      _$CustomCalendarItemFromJson(json);
}
