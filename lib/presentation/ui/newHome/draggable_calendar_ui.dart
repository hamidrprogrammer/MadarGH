import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/core/locale/locale_extension.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/newHome/CalendarItemUi.dart';
import 'package:my_ios_app/presentation/ui/newHome/new_home_ui.dart';
import 'package:my_ios_app/presentation/ui/newHome/week_item_ui.dart';
import 'package:my_ios_app/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';
import 'package:my_ios_app/presentation/uiModel/newHome/calendar_object_draggable.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DraggableCalendarUi extends StatefulWidget {
  DraggableCalendarUi({
    Key? key,
    required this.items,
    required this.onClick,
    required this.selectedChild,
  }) : super(key: key);
  final List<CalendarItems> items;
  final days = CalendarObjectDraggable().items;
  final ChildsItem selectedChild;
  //this boolean means -> if false the root list should be empty else should send to server;
  final Function(bool) onClick;

  @override
  State<DraggableCalendarUi> createState() => _DraggableCalendarUiState();
}

class _DraggableCalendarUiState extends State<DraggableCalendarUi> {
  var enabled = false;
  Color hexToColor(String? hexColor) {
    // Check if the color string is null or empty
    if (hexColor == null || hexColor.isEmpty) {
      return Colors.black; // Return a default color if null
    }

    // Remove the '#' if present
    hexColor = hexColor.replaceAll('#', '');

    // Check if the color string is of valid length
    if (hexColor.length == 6) {
      // Convert RRGGBB to ARGB
      hexColor = 'FF$hexColor'; // Add full opacity
    } else if (hexColor.length == 8) {
      // Keep as is for AARRGGBB
    } else {
      // Invalid format, return a default color
      return Colors.black; // Or throw an error
    }

    return Color(int.parse('0x$hexColor'));
  }

  String getDateWithMonth(DateTime nextAssessmentDate) {
    print(nextAssessmentDate);
    String date = '';
   final locale = Get.locale;
if (locale != null && locale.languageCode == 'fa') {
  var f = Jalali(nextAssessmentDate.year, nextAssessmentDate.month, nextAssessmentDate.day).formatter;
  date = '${f.d} ${f.mN}';
} else {
  var localDate = nextAssessmentDate.toLocal();
  date = DateFormat.MMMd().format(localDate);
}
    return date;
  }

  @override
  Widget build(BuildContext context) {
    bool isToday(DateTime someDate) {
      var today = Jalali.now();
      return someDate.day == today.day &&
          someDate.month == today.month &&
          someDate.year == today.year;
    }

    return Column(
      children: [
        SizedBox(
          height: widget.items.length * 65,
          child: Padding(
            padding: 8.dpeh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Column(
                //   children: widget.days.map((item) {
                //     return WeekItemUi(item: item);
                //   }).toList(),
                // ),
                8.dph,
                Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = widget.items.removeAt(oldIndex);
                        widget.items.insert(newIndex, item);
                      });
                    },
                    primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    children: widget.items.map((item) {
                      return ReorderableDragStartListener(
                        key: Key(item.dayOfWeek.toString()),
                        index: widget.items.indexOf(item),
                        enabled: enabled,
                        child: 
                        ShakeWidget(
                          shakeConstant: ShakeLittleConstant2(),
                          autoPlay: enabled,
                          enableWebMouseHover: false,
                          child: SizedBox(
                            height: 65,
                            child: ScheduleItem(
                                day:
                                    '${widget.days[widget.items.indexOf(item)].name ?? ''} : ${getDateWithMonth(item.nextAssessmentDate!) ?? ''}',
                                title: '${item.parentCategory?.title ?? ''}',
                                iconPath: './assets/group-22-4.svg',
                                backgroundColor: Color(0xFFFDEFEF),
                                borderColor: item.colorNumber != null
                                    ? hexToColor(item.colorNumber)
                                    : Colors.grey,
                                showButton: isToday(item.nextAssessmentDate!),
                                mode: CalendarMode.calendar,
                                items: item,
                                onPress: () {
                                  AssessmentParamsModel assessmentParam =
                                      AssessmentParamsModel(
                                    name: widget.selectedChild.childFirstName ??
                                        '',
                                    id: item.userChildWorkShopId?.toString() ??
                                        ''
                                            '',
                                    childId:
                                        widget.selectedChild.id?.toString() ??
                                            '',
                                    workShopId:
                                        item.workShopId?.toString() ?? '',
                                    course: item.parentCategory?.title ?? '',
                                  );
                                  GetIt.I
                                      .get<NavigationServiceImpl>()
                                      .navigateTo(
                                        AppRoute.assessments,
                                        assessmentParam,
                                      );
                                 
                                }),
                            // CalendarItemUi(
                            //   item: item,
                            //   mode: CalendarMode.calendar,
                            //   index: widget.items.indexOf(item),
                            // ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'You_can_customize_your_weekly_schedule_by_switching_days'.tr,
            style: TextStyle(
              fontFamily: 'IRANSansXFaNum',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Color(0xFF2E754E),
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: 16.dpeh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: 16.bRadius,
                  border: Border.all(color: Color.fromARGB(255, 165, 0, 69)),
                ),
                child: TextButton.icon(
                  icon: const Icon(Icons.add_circle),
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 165, 0, 69),
                      fontSize: 12.0,
                       fontFamily: 'IRANSansXFaNum',
                    ),
                    iconColor: Color.fromARGB(255, 165, 0, 69),
                    surfaceTintColor: Colors.grey,
                  ),
                  onPressed: () {
                    widget.onClick.call(enabled);
                    setState(() {
                      enabled = !enabled;
                    });
                  },
                  label: Text(
                    enabled ? 'save'.tr : 'customize_calendar'.tr,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
