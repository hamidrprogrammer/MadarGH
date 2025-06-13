import 'package:flutter/material.dart';
import 'package:my_ios_app/data/body/calendar/home_calendar.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';

class WeeklyPlanSheet extends StatelessWidget {
  final ChildsItem childsItem;

  const WeeklyPlanSheet({super.key, required this.childsItem});

  @override
  Widget build(BuildContext context) {
    return HomeCalendarUi(selectedChild: childsItem);
  }
}
