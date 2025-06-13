import 'dart:convert';

import 'package:core/Notification/MyNotification.dart';
import 'package:core/Notification/MyNotificationListener.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/GetChildsOfUserUseCase.dart';
import 'package:my_ios_app/useCase/workBook/general_reportCard_useCase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NewHomeViewModel extends BaseViewModel with MyNotificationListener {
  final MyNotification _notification = GetIt.I.get();
  AppState childState = AppState.idle;
  bool newUi = true;

  NewHomeViewModel(super.initialState) {
    _notification.subscribeListener(this);
    getChildOfUser();
  }

  AppState reportCardState = AppState.idle;
  get getUserChild async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionChildConst.id);
  ChildsItem? selected;
  final LocalSessionImpl _localSessionImpl = GetIt.I.get();
  getData() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    return "";// Retrieve the saved string
  }

  onSelectNewChildStorge(ChildsItem newChild) async {
    print("newChild.onSelectNewChildStorge");
    print(newChild.id!);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString =
        childsItemToJson([newChild]); // Convert single item to JSON string
    // await prefs.setString('child_item', jsonString);
    _notification.publish('MyWorkShopsViewModel', newChild);
    refresh();
  }

  Future<ChildsItem?> getChildItem() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "";
    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      print('child_item');
      print(items.length.toString());

      return items.isNotEmpty
          ? items.first
          : null; // Return the first item or null if the list is empty
    } else {
      return null; // Return null if no data is found
    }
  }

  onSelectNewChild(ChildsItem newChild) async {
    print("newChild.childLastName");
    print(newChild.id!);

    selected = newChild;
    getGeneralReportCard();
    _notification.publish('CalendarViewModel', newChild.id!);
    _notification.publish('MyWorkShopsViewModel', newChild);
    refresh();
  }

  @override
  void onReceiveData(data) {
    if (data != null) {
      if (data is bool) {
        getChildOfUser();
      }
      if (data is ChildsItem) {
        onSelectNewChild(data);
      }
    }
  }

  @override
  String tag() => 'NewHomeViewModel';

  @override
  Future<void> close() {
    _notification.removeSubscribe(this);
    return super.close();
  }
  void getChildOfUserAge() {
    GetChildOfUserUseCase().invokeAge(MyFlow(flow: (appState) {

    }));
  }
  void getChildOfUser() {
    GetChildOfUserUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.getErrorModel?.state == ErrorState.Empty) {
        newUi = false;
      }
      print("===============>");
      print(appState.getData);
      if (appState.isSuccess) {
        if (appState.getData is List<ChildsItem>) {
          List<ChildsItem> child = appState.getData;
          if (child.isNotEmpty) {
            selected = child.first;
            childState = appState;
            onSelectNewChild(child.first);
            newUi = true;
            _notification.publish('MyWorkShopsViewModel', child.first);
            print('data has been send');
            // _notification.publish('NewHomeViewModel', selected);
          }
        }
      }
      refresh();
    }));
  }
  Future<void> getGeneralReportCardByPacage(String idAge) async {
    print("selected"+idAge);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "";
    print("selected"+jsonString.toString());
    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      print(items.first?.childFirstName.toString());
      GeneralReportCardUseCase().invokePcage(
        MyFlow(flow: (appState) {
          if (appState.isSuccess &&
              appState.getData is WorkBookDetailResponse) {
            reportCardState = AppState.success(
                (appState.getData as WorkBookDetailResponse)
                    .createUiModel(null));
          } else {
            reportCardState = appState;
          }
          refresh();
        }),
        data: items.first?.id!,
        dataT: idAge,
      );
    }
  }
  Future<void> getGeneralReportCard() async {
    print("selected");
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "";

    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      print(items.first?.childFirstName.toString());
      GeneralReportCardUseCase().invoke(
        MyFlow(flow: (appState) {
          if (appState.isSuccess &&
              appState.getData is WorkBookDetailResponse) {
            reportCardState = AppState.success(
                (appState.getData as WorkBookDetailResponse)
                    .createUiModel(null));
          } else {
            reportCardState = appState;
          }
          refresh();
        }),
        data: items.first?.id!,
      );
    }
  }

  ChartDataModel getTotalChartData(
      List<GeneralReportCard>? cards, List<WorkShopCategory> categories) {
    List<String> names = categories.map((e) => e.name).toList();
    var maxValue = cards?.fold(
            0,
            (previousValue, element) =>
                previousValue > element.workShopReportCards.getMaxValue
                    ? previousValue
                    : element.workShopReportCards.getMaxValue) ??
        0;

    List<String> lableData = [];
    List<double> values = categories.map((e) {
      var id = e.id;

      var correct = 0;

      var all = 0;

      var currentValues = getTotalWorkBookThirdRate(id, cards);
      currentValues?.map((e) {
        correct += e.thirdRateAnswersCount ?? 0;
        all += e.allQuestionsCount ?? 0;
      }).toList();
      lableData.add('$correct ${'from'.tr} $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();
    if (cards != null && cards.length == 2) {
      List<double> valuesWt = categories.map((e) {
        var id = e.id;

        var correct = 0;

        var all = 0;

        var currentValues = getTotalWorkBookThirdRateT(id, cards);
        currentValues?.map((e) {
          correct += e.thirdRateAnswersCount ?? 0;
          all += e.allQuestionsCount ?? 0;
        }).toList();
        lableData.add('$correct ${'from'.tr} $all');
        var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
        return result;
      }).toList();
      return ChartDataModel(
          maxValue: maxValue,
          name: names,
          values: [values, valuesWt],
          lableData: lableData);
    } else {
      return ChartDataModel(
          maxValue: maxValue,
          name: names,
          values: [values],
          lableData: lableData);
    }
  }

  List<WorkShopReportCard>? getTotalWorkBookThirdRateT(
      String id, List<GeneralReportCard>? cards) {
    List<WorkShopReportCard> values = [];

    cards?[1].workShopReportCards?.forEach((element) {
      if (id.toString() ==
          (element.workShopDictionary?.categoryId?.toString() ?? '0')) {
        values.add(element);
      }
    });

    return values;
  }

  List<WorkShopReportCard>? getTotalWorkBookThirdRate(
      String id, List<GeneralReportCard>? cards) {
    List<WorkShopReportCard> values = [];

    cards?[0].workShopReportCards?.forEach((element) {
      if (id.toString() ==
          (element.workShopDictionary?.categoryId?.toString() ?? '0')) {
        values.add(element);
      }
    });

    return values;
  }

  List<String> getUserWorkShops(List<GeneralReportCard>? cards) {
    List<String> workShops = [];
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        workShops.add(element.workShopDictionary?.name ?? '');
      });
    });
    return workShops;
  }
}
