import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/newHome/draggable_calendar_ui.dart';
import 'package:my_ios_app/presentation/ui/newHome/verticalSlider/VerticalSlider.dart';
import 'package:my_ios_app/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';
import 'package:my_ios_app/presentation/viewModel/calendar/calendar_viewModel.dart';

class HomeCalendarUi extends StatefulWidget {
  const HomeCalendarUi({
    Key? key,
    required this.selectedChild,
  }) : super(key: key);
  final ChildsItem selectedChild;

  @override
  State<HomeCalendarUi> createState() => _HomeCalendarUiState();
}

class _HomeCalendarUiState extends State<HomeCalendarUi> {
  late CalendarViewModel viewModel;

  @override
  void initState() {
    viewModel = CalendarViewModel(AppState.idle);
    viewModel.setUserChildId(widget.selectedChild.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => viewModel,
      builder: (bloc, state) {
        return ConditionalUI<UserCalendarResponse>(
          state: bloc.calendarState,
      onSuccess: (data) {
  final items = data?.calendarItems;

   if (items != null) {
    items.sort((a, b) {
      final aDay = a.dayOfWeek ?? 0;
      final bDay = b.dayOfWeek ?? 0;
      return aDay.compareTo(bDay);
    });
  }

  return Column(
    children: [
      4.dpv,
      DraggableCalendarUi(
        items: items ?? [],
        onClick: bloc.onSubmitClick,
        selectedChild: widget.selectedChild,
      ),
    ],
  );
},
        );
      },
    );
  }
}
