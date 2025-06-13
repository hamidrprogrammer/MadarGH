import 'package:json_annotation/json_annotation.dart';
import 'package:my_ios_app/data/body/calendar/custom_calendar_item.dart';

part 'UserCustomCalendarBody.g.dart';

@JsonSerializable(explicitToJson: true)
class UserCustomCalendarBody {
  final String userChildId, packageId;
  final List<CustomCalendarItem> items;

  UserCustomCalendarBody({
    required this.userChildId,
    required this.packageId,
    required this.items,
  });

  Map<String, dynamic> toJson() =>
      _$UserCustomCalendarBodyToJson(this);

  UserCustomCalendarBody fromJson(Map<String, dynamic> json) =>
      _$UserCustomCalendarBodyFromJson(json);
}
