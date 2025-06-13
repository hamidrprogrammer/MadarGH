import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:core/utils/logger/Logger.dart';
import 'package:my_ios_app/data/body/calendar/UserCustomCalendarBody.dart';
import 'package:my_ios_app/data/body/calendar/custom_calendar_item.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/data/serializer/child/add_suitable_workshop_usecase.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/calendar/customize_calendar_useCase.dart';
import 'package:my_ios_app/useCase/calendar/get_user_calendar_use_case.dart';

class CalendarViewModel extends BaseViewModel
    implements MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();

  CalendarViewModel(super.initialState) {
    _notification.subscribeListener(this);
  }

  UserCustomCalendarBody? body;
  UserCalendarResponse? response;
  int? userChildId;

  AppState calendarState = AppState.idle;

  void getUserCalendar() {
    GetUserCalendarUseCase().invoke(
      MyFlow(flow: (appState) {
        if (appState.isSuccess) {
          if (appState.getData is UserCalendarResponse) {
            response = appState.getData;
            body = UserCustomCalendarBody(
              userChildId: userChildId?.toString() ?? '',
              packageId: response?.packageId?.toString() ?? '',
              items: [],
            );
            calendarState = appState;
          } else if (appState.getData is int) {
            AddSuitableWorkShopUseCase().invoke(
                MyFlow(flow: (addWorkShopState) {
              if (addWorkShopState.isSuccess) {
                getUserCalendar();
              } else {
                calendarState = addWorkShopState;
                refresh();
              }
            }), data: userChildId!,);
          } else {
            calendarState = appState;
          }
        }else{
          calendarState = appState;
        }
        refresh();
      }),
      data: userChildId!,
    );
  }

  onChangeItem(List<CalendarItems> items) {
    if (response != null && body != null) {
      items.asMap().forEach((index, item) {
        var newItem = CustomCalendarItem(
          parentCategoryId: item.parentCategory?.id?.toString() ?? '',
          dayOfWeek: (index + 1).toString(),
        );
        body?.items.add(newItem);
      });
    }
  }

  setUserChildId(int newChildId) {
    userChildId = newChildId;
    getUserCalendar();
  }

  onSubmitClick(bool enable) async {
    if (enable) {
      if (body != null) {
        await collectChanges();
        submitChanges(body!);
      } else {
        Logger.e('body is null');
      }
    } else {
      body?.items.clear();
    }
  }

  submitChanges(UserCustomCalendarBody body) {
    CustomizeCalendarUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        getUserCalendar();
        Logger.d('successfully submitted changes');
      } else if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }), data: body);
  }

  Future<bool> collectChanges() {
    if (response != null && response?.calendarItems != null && body != null) {
      response?.calendarItems?.asMap().forEach((index, item) {
        var newItem = CustomCalendarItem(
          parentCategoryId: item.parentCategory?.id?.toString() ?? '',
          dayOfWeek: (index + 1).toString(),
        );
        body?.items.add(newItem);
      });
    }
    return Future.value(true);
  }

  @override
  void onReceiveData(data) {
    userChildId = data;
    getUserCalendar();
  }

  @override
  String tag() => 'CalendarViewModel';

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
}
