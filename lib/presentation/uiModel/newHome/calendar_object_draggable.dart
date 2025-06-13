import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/uiModel/newHome/calendar_item.dart';
import 'package:my_ios_app/presentation/uiModel/newHome/week_item.dart';

class CalendarObjectDraggable {
  List<WeekItem> items = [
    WeekItem(id: 0, name: 'sunday'.tr),
    WeekItem(id: 1, name: 'saturday'.tr),
    WeekItem(id: 2, name: 'monday'.tr),
    WeekItem(id: 3, name: 'tuesday'.tr),
    WeekItem(id: 4, name: 'wednesday'.tr),
  ];


  Map<WeekItem, CalendarItem> remindersItem = {
    const WeekItem(id: 0, name: 'شنبه'): CalendarItem(
      id: 0,
      name: '۶ روز ماده',
      assessment: 'ریاضی',
      date: '21',
      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0),
    ),
    const WeekItem(id: 1, name: 'یک ش'): CalendarItem(
      id: 1,
      name: '۶ روز ماده',
      assessment: 'ارزیابی اول',
      date: '05',
      color: Colors.grey.shade200,
    ),
    WeekItem(id: 2, name: 'دو ش'): CalendarItem(
      id: 2,
      name: '۶ روز ماده',
      assessment: 'ارزیابی اول',
      date: '10',
      color: Colors.grey.shade200,
    ),
  };
}
