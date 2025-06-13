import 'package:core/color/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarItemUi extends StatelessWidget {
  const CalendarItemUi({
    Key? key,
    required this.item,
    required this.mode,
    required this.index,
    this.selectedIndex,
    this.itemClicked,
  }) : super(key: key);
  final CalendarItems item;
  final CalendarMode mode;
  final int index;
  final int? selectedIndex;
  final Function(CalendarItems)? itemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: 4.dpe,
      margin: 2.dpe,
      decoration: BoxDecoration(
        borderRadius: 12.bRadius,
        border: Border.all(
            color: mode == CalendarMode.calendar
                ? Colors.grey
                : Colors.grey.shade400,
            width: 1.0),
        color: mode == CalendarMode.calendar
            ? item.parentCategory?.colorNumber?.toColor()
            : Colors.grey.shade200,
      ),
      child: Padding(
        padding: 4.dpeh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: 4.dpeh,
              child: Text(
                  mode == CalendarMode.reminder
                      ? item.nextAssessmentDate != null
                          ? getDifferent(item.nextAssessmentDate!)
                          : ''
                      : item.parentCategory?.title ?? '',
                  style: context.textTheme.titleMedium),
            ),
            if (mode == CalendarMode.reminder)
              Text(item.parentCategory?.title ?? '',
                  style: context.textTheme.titleSmall),
            mode == CalendarMode.calendar ||
                    item.nextAssessmentDate != null &&
                        !isToday(item.nextAssessmentDate!)
                ? item.nextAssessmentDate != null
                    ? Container(
                        alignment: Alignment.center,
                        padding: 4.dpe,
                        margin: 4.dpe,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: 8.bRadius,
                          color: Colors.white,
                        ),
                        child: Text(getDateWithMonth(item.nextAssessmentDate!)),
                      )
                    : const SizedBox(height: 35)
                : ElevatedButton(
                    onPressed: () {
                      itemClicked?.call(item);
                    },
                    child: Text(
                      'start_test'.tr,
                      style: TextStyle(fontSize: 9,  fontFamily: 'IRANSansXFaNum',),
                    ))
          ],
        ),
      ),
    );
  }

  getDifferent(DateTime nextAssessmentDate) {
    // if(Get.locale.isPersian){
    //   nextAssessmentDate = Jalali(nextAssessmentDate.year,nextAssessmentDate.month,nextAssessmentDate.day).toDateTime();
    // }
    if (isToday(nextAssessmentDate)) return 'today'.tr;
    Jalali jalaliNow = Jalali.now();
    DateTime now = Get.locale.isPersian
        ? DateTime(jalaliNow.year, jalaliNow.month, jalaliNow.day)
        : DateTime.now();
    var days = nextAssessmentDate.difference(now).inDays;
    var hours = nextAssessmentDate.difference(now).inHours;
    if (days == 0) {}
    var ht = 'hours_till'.tr;
    var dt = 'days_till'.tr;

    if (hours > 0 && hours < 24) return "$hours $ht";
    return "$days $dt";
  }

  bool isToday(DateTime someDate) {
    var today = Jalali.now();
    return someDate.day == today.day &&
        someDate.month == today.month &&
        someDate.year == today.year;
  }

  String getDateWithMonth(DateTime nextAssessmentDate) {
    print(nextAssessmentDate);
    String date = '';
    if (Get.locale.isPersian) {
      var f = Jalali(nextAssessmentDate.year, nextAssessmentDate.month,
              nextAssessmentDate.day)
          .formatter;
      date = '${f.d} ${f.mN}';
    } else {
      var localDate = nextAssessmentDate.toLocal();
      date = DateFormat.MMMd().format(localDate);
    }
    return date;
  }
}

enum CalendarMode {
  calendar,
  reminder;
}
