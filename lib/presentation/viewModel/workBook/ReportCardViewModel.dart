import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/apiRoute/BaseUrls.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/ui/workBook/DownloadFileDialog.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/workBook/ReportCardUseCase.dart';
import 'package:my_ios_app/useCase/workBook/general_reportCard_useCase.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

class ReportCardViewModel extends BaseViewModel {
  final key = GlobalKey();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  WorkBookParamsModel? model;
  AppState reportCardState = AppState.idle;
  AppState reportCardTopicZState = AppState.idle;

  ReportCardViewModel(super.initialState) {
    getExtra();
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
  Future<ChildsItem?> getChildItem() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "prefs.getString('child_item')";

    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      print('child_item');
      print('Number of items: ${items.length}');

      return items.isNotEmpty ? items.first : null;
    } else {
      print('No child item found in SharedPreferences');
      return null;
    }
  }

  void getExtra() {
    model = _navigationServiceImpl.getArgs();
    if (model != null && model is WorkBookParamsModel) {
      print('model is ${model?.toJson()}');
      getReportCard(model!);
      Future.delayed(Duration(seconds: 3), () {
                 if(model!= null){
                             getGeneralReportCardByPacage(model!.idPack.toString());

                 }


    });
    }
  }
 Future<void> getGeneralReportCardByPacage(String idAge) async {
    print("selected"+idAge);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "prefs.getString('child_item')";
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
  void getReportCard(WorkBookParamsModel model) {
    ReportCardUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is WorkBookDetailResponse) {
         reportCardTopicZState = AppState.success(
                (appState.getData as WorkBookDetailResponse)
                    .createUiModel(null));
      } else {
        mainFlow.emit(appState);
      }
    }), data: model);
  }

  Future<Uint8List?> takeSnapShot() async {
    final RenderRepaintBoundary boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void getWorkBookShot() async {
    if (model != null) {
      String path =
          'https://admindashboard.mamakschool.ir/report/card/download/${model?.userChildId}/${model?.workShopId}/${Get.locale?.toLanguageTag()}';
      _launchUrl(path);
    } else {
      messageService.showSnackBar('fail_receive_report_card'.tr);
    }
  }

  void getLastWorkBook() async {
    if (model != null) {
      String path =
          'https://${BaseUrls.baseUrl}/report/card/download/${model?.userChildId}/${model?.lastWorkShopId}/${Get.locale?.toLanguageTag()}';
      _launchUrl(path);
    } else {
      messageService.showSnackBar('fail_receive_report_card'.tr);
    }
  }

  Future<void> _launchUrl(String url) async {
    // if (!await launchUrl(Uri.parse(url),
    //     mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch $url');
    // }
  }

  onSolutionItemClick(WorkBookDetailReviews item) {
    if (item.fileDataId != null) {
      _navigationServiceImpl
          .dialog(DownloadFileDialog(fileDataId: item.fileDataId!));
    }
  }
}

class AccordionViewModel extends BaseViewModel with WidgetsBindingObserver {
  final key = GlobalKey();
  WorkBookParamsModel? model;
  AppState uiState = AppState.idle;
  List<Accordion> accordionList = [];

  AccordionViewModel(super.initialState, String index) {
    WidgetsBinding.instance.addObserver(this);

    getExtra(index);
  }

  void getExtra(String index) {
    getReportCard(index);
  }

  void getChange(int index, List<Accordion> data) {
    if (data != null) {
      if (index >= 0 && index < data.length) {
        for (int i = 0; i < data.length; i++) {
          if (i != index) {
            data[i].isExpanded = false;
          }
        }

        // Toggle expansion state of the item at the specified index
        final Accordion item = data[index];
        item.isExpanded = !item.isExpanded;

        // Perform any other necessary actions here

        // Emit the updated state to trigger UI refresh
        mainFlow.emit(AppState.success(List<Accordion>.from(data)));
      } else {
        print("Invalid indsex: $index"); // Handle invalid index
      }
    } else {
      print("Accordion list is null"); // Handle null list
    }
  }

  void getReportCard(String index) {
    AccordiondUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is Accordion) {
        print("gsetData" + appState.getData.toString());
        accordionList = appState.getData as List<Accordion>;
        mainFlow.emit(AppState.success(accordionList));
      } else {
        mainFlow.emit(appState);
      }
    }), data: index);
  }
}
