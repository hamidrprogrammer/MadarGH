import 'package:core/card_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/newHome/CalendarItemUi.dart';
import 'package:shamsi_date/shamsi_date.dart';

class
VerticalSliderUi extends StatefulWidget {
  const VerticalSliderUi({
    Key? key,
    required this.items,
    required this.todayClicked,
  }) : super(key: key);
  final List<CalendarItems> items;
  final Function(CalendarItems) todayClicked;

  @override
  State<VerticalSliderUi> createState() => _VerticalSliderUiState();
}

class _VerticalSliderUiState extends State<VerticalSliderUi> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<CalendarItems> list = List.from(widget.items);
list.removeWhere((element) =>
    element.nextAssessmentDate == null ||
    !(element.nextAssessmentDate!.isAfter(DateTime.now())));
list.sort((a, b) {
  final dateA = a.nextAssessmentDate;
  final dateB = b.nextAssessmentDate;
  if (dateA == null && dateB == null) return 0;
  if (dateA == null) return 1; // nulls go to the end
  if (dateB == null) return -1;
  return dateA.compareTo(dateB);
});

    return SizedBox(
      height: 170,
      child: CardStackWidget(
        cardList: list.map((item) {
          return CardModel(
            key: Key(item.userChildWorkShopId?.toString() ?? ''),
            radius: 16.radius,
            index: list.indexOf(item),
            child: Opacity(
              opacity: .7,
              child: CalendarItemUi(
                item: item,
                mode: CalendarMode.reminder,
                index: list.indexOf(item),
                selectedIndex: selectedIndex,
                itemClicked: (clickedItem) {
                  if (clickedItem.nextAssessmentDate != null &&
                      isToday(clickedItem.nextAssessmentDate!)) {
                    widget.todayClicked.call(clickedItem);
                  }
                },
              ),
            ),
            border: Border.all(color: Colors.transparent, width: 0.0),
            shadowBlurRadius: 0.0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.orange,
          );
        }).toList(),
        opacityChangeOnDrag: true,
        swipeOrientation: CardOrientation.both,
        cardDismissOrientation: CardOrientation.both,
        positionFactor: 1.2,
        scaleFactor: 0.9,
        alignment: Alignment.center,
        reverseOrder: true,
        animateCardScale: true,
        dismissedCardDuration: const Duration(milliseconds: 100),
        onChangeIndex: (data) {
          if (selectedIndex != data) {
            selectedIndex = data;
            // setState(() {});
          }
        },
        onCardTap: (cardModel) {
          // int key = int.parse(cardModel.key?.toString().replaceAll('[<>', '') ?? '');
          var itemIndex = widget.items.indexWhere((element) =>
              element.userChildWorkShopId?.toString().replaceAll('[<>', '') ==
              cardModel.key?.toString());
          if (itemIndex != -1) {
            var data = widget.items.elementAt(itemIndex);
            if (data.nextAssessmentDate != null &&
                isToday(data.nextAssessmentDate!)) {
              widget.todayClicked.call(data);
            }
          } else {}
        },
      ),
    );
  }

  bool isToday(DateTime someDate) {
    var today = Jalali.now();
    return someDate.day == today.day &&
        someDate.month == today.month &&
        someDate.year == today.year;
  }
}
