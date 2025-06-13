// To parse this JSON data, do
//

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final workBookDetailResponse = workBookDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkShopDictionary.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookTableModel.dart';

import 'WorkShopReportItem.dart';

WorkBookDetailResponse workBookDetailResponseFromJson(String str) =>
    WorkBookDetailResponse.fromJson(json.decode(str));

String workBookDetailResponseToJson(WorkBookDetailResponse data) =>
    json.encode(data.toJson());

class WorkBookDetailResponse {
  ReportCardHeader? reportCardHeader;
  WorkShopReportCard? workShopReportCard;
  WorkShopReportItem? firstWorkShopReportCard;
  WorkShopReportItem? lastWorkShopReportCard;
  List<WorkShopReportItem>? firstWorkShopSubCategoryReportCards;
  List<WorkShopReportItem>? lastWorkShopSubCategoryReportCards;
  List<WorkShopReportCardDetail>? workShopReportCardDetails;
  List<GeneralReportCard>? generalReportCards;
  GeneralReportCardDetails? generalReportCardDetails;
  List<WorkShopReportCard>? workShopSubCategoryReportCards;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  WorkBookDetailResponse({
    this.reportCardHeader,
    this.workShopReportCard,
    this.workShopReportCardDetails,
    this.generalReportCards,
    this.generalReportCardDetails,
    this.workShopSubCategoryReportCards,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
    this.firstWorkShopReportCard,
    this.lastWorkShopReportCard,
    this.firstWorkShopSubCategoryReportCards,
    this.lastWorkShopSubCategoryReportCards,
  });

  factory WorkBookDetailResponse.fromJson(Map<String, dynamic> json) =>
      WorkBookDetailResponse(
        reportCardHeader: json["reportCardHeader"] == null
            ? null
            : ReportCardHeader.fromJson(json["reportCardHeader"]),
        workShopReportCard: json["workShopReportCard"] == null
            ? null
            : WorkShopReportCard.fromJson(json["workShopReportCard"]),
        workShopReportCardDetails: json["workShopReportCardDetails"] == null
            ? []
            : List<WorkShopReportCardDetail>.from(
                json["workShopReportCardDetails"]!
                    .map((x) => WorkShopReportCardDetail.fromJson(x))),
        generalReportCards: json["generalReportCards"] == null
            ? []
            : List<GeneralReportCard>.from(json["generalReportCards"]!
                .map((x) => GeneralReportCard.fromJson(x))),
        generalReportCardDetails: json["generalReportCardDetails"] == null
            ? null
            : GeneralReportCardDetails.fromJson(
                json["generalReportCardDetails"]),
        workShopSubCategoryReportCards:
            json["workShopSubCategoryReportCards"] == null
                ? []
                : List<WorkShopReportCard>.from(
                    json["workShopSubCategoryReportCards"]!
                        .map((x) => WorkShopReportCard.fromJson(x))),
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
        firstWorkShopReportCard: json["firstWorkShopReportCard"] != null
            ? workShopReportItemFromJson(
                jsonEncode(json["firstWorkShopReportCard"]))
            : null,
        lastWorkShopReportCard: json["lastWorkShopReportCard"] != null
            ? workShopReportItemFromJson(
                jsonEncode(json["lastWorkShopReportCard"]))
            : null,
        firstWorkShopSubCategoryReportCards:
            json["firstWorkShopSubCategoryReportCards"] != null
                ? List<WorkShopReportItem>.from(
                    json["firstWorkShopSubCategoryReportCards"]
                        .map((x) => workShopReportItemFromJson(jsonEncode(x))))
                : null,
        lastWorkShopSubCategoryReportCards:
            json["lastWorkShopSubCategoryReportCards"] != null
                ? List<WorkShopReportItem>.from(
                    json["lastWorkShopSubCategoryReportCards"]
                        .map((x) => workShopReportItemFromJson(jsonEncode(x))))
                : null,
      );

  Map<String, dynamic> toJson() => {
        "reportCardHeader": reportCardHeader?.toJson(),
        "workShopReportCard": workShopReportCard?.toJson(),
        "workShopReportCardDetails": workShopReportCardDetails?.map((x) => x.toJson()).toList() ?? [],
"generalReportCards": generalReportCards?.map((x) => x.toJson()).toList() ?? [],
"generalReportCardDetails": generalReportCardDetails?.toJson(),
"workShopSubCategoryReportCards": workShopSubCategoryReportCards?.map((x) => x.toJson()).toList() ?? [],
"id": id,
"errorMessages": errorMessages?.map((x) => x).toList() ?? [],
"statusCode": statusCode,
"successfulMessages": successfulMessages?.map((x) => x).toList() ?? [],
      };
}

class GeneralReportCardDetails {
  Map<String, String>? allWorkShopsDictionary;
  int? allWorkShopsCount;
  int? participatedWorkShopsCount;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  GeneralReportCardDetails({
    this.allWorkShopsDictionary,
    this.allWorkShopsCount,
    this.participatedWorkShopsCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory GeneralReportCardDetails.fromJson(Map<String, dynamic> json) =>
      GeneralReportCardDetails(
        allWorkShopsDictionary: json["allWorkShopsDictionary"] == null
            ? null
            : Map.from(json["allWorkShopsDictionary"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        allWorkShopsCount: json["allWorkShopsCount"],
        participatedWorkShopsCount: json["participatedWorkShopsCount"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "allWorkShopsCount": allWorkShopsCount,
        "participatedWorkShopsCount": participatedWorkShopsCount,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

class Dictionary {
  String? the1;

  Dictionary({
    this.the1,
  });

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        the1: json["1"],
      );

  Map<String, dynamic> toJson() => {
        "1": the1,
      };
}

class GeneralReportCard {
  List<WorkShopReportCard>? workShopReportCards;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  GeneralReportCard({
    this.workShopReportCards,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory GeneralReportCard.fromJson(Map<String, dynamic> json) =>
      GeneralReportCard(
        workShopReportCards: json["workShopReportCards"] == null
            ? []
            : List<WorkShopReportCard>.from(json["workShopReportCards"]!
                .map((x) => WorkShopReportCard.fromJson(x))),
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "workShopReportCards": workShopReportCards == null
            ? []
            : List<dynamic>.from(workShopReportCards!.map((x) => x.toJson())),
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

class WorkShopReportCard {
  WorkShopDictionary? workShopDictionary;
  int? allQuestionsCount;
  int? firstRateAnswersCount;
  int? secondRateAnswersCount;
  int? thirdRateAnswersCount;
  int? userParticipateAssessmentCount;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;
  Map<String, String>? categoryDictionary;

  WorkShopReportCard({
    this.workShopDictionary,
    this.allQuestionsCount,
    this.firstRateAnswersCount,
    this.secondRateAnswersCount,
    this.thirdRateAnswersCount,
    this.userParticipateAssessmentCount,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
    this.categoryDictionary,
  });

  factory WorkShopReportCard.fromJson(Map<String, dynamic> json) =>
      WorkShopReportCard(
        workShopDictionary: json["workShopDictionary"] == null
            ? null
            : WorkShopDictionary.fromJson(json["workShopDictionary"]),
        allQuestionsCount: json["allQuestionsCount"],
        firstRateAnswersCount: json["firstRateAnswersCount"],
        secondRateAnswersCount: json["secondRateAnswersCount"],
        thirdRateAnswersCount: json["thirdRateAnswersCount"],
        userParticipateAssessmentCount: json["userParticipateAssessmentCount"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
        categoryDictionary: json["categoryDictionary"] == null
            ? null
            : Map.from(json["categoryDictionary"]!)
                .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "workShopDictionary": workShopDictionary?.toString(),
        "allQuestionsCount": allQuestionsCount,
        "firstRateAnswersCount": firstRateAnswersCount,
        "secondRateAnswersCount": secondRateAnswersCount,
        "thirdRateAnswersCount": thirdRateAnswersCount,
        "userParticipateAssessmentCount": userParticipateAssessmentCount,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
        "categoryDictionary": Map.from(categoryDictionary!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class ReportCardHeader {
  String? parentUserFullName;
  String? childUserFullName;
  String? childFullAge;
  int? childAge;
  String? workShopCategoryTitle;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ReportCardHeader({
    this.parentUserFullName,
    this.childUserFullName,
    this.childFullAge,
    this.childAge,
    this.workShopCategoryTitle,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ReportCardHeader.fromJson(Map<String, dynamic> json) =>
      ReportCardHeader(
        parentUserFullName: json["parentUserFullName"],
        childUserFullName: json["childUserFullName"],
        childFullAge: json["childFullAge"],
        childAge: json["childAge"],
        workShopCategoryTitle: json["workShopCategoryTitle"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "parentUserFullName": parentUserFullName,
        "childUserFullName": childUserFullName,
        "childFullAge": childFullAge,
        "childAge": childAge,
        "workShopCategoryTitle": workShopCategoryTitle,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

class WorkShopReportCardDetail {
  String? question;
  String? answer;
  String? solutionFileId;
  num? answerRate;
  int? id;
  int? questionId;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  WorkShopReportCardDetail({
    this.question,
    this.answer,
    this.solutionFileId,
    this.answerRate,
    this.id,
    this.questionId,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory WorkShopReportCardDetail.fromJson(Map<String, dynamic> json) =>
      WorkShopReportCardDetail(
        question: json["question"],
        questionId: json["questionId"],
        solutionFileId: json["solutionFileId"],
        answerRate: json["answerRate"],
        answer: json["answer"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "solutionFileId": solutionFileId,
        "answerRate": answerRate,
        "id": id,
        "errorMessages": errorMessages == null
            ? []
            : List<dynamic>.from(errorMessages!.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages": successfulMessages == null
            ? []
            : List<dynamic>.from(successfulMessages!.map((x) => x)),
      };
}

extension WorkBookDetailExtension on WorkBookDetailResponse {
  List<WorkShopCategory> get workShopCategories {
    return generalReportCardDetails?.allWorkShopsDictionary?.keys.map((e) {
          var name = generalReportCardDetails?.allWorkShopsDictionary?[e] ?? '';
          return WorkShopCategory(name: name, id: e);
        }).toList() ??
        [];
  }

  WorkBookDetailUiModel createUiModel(WorkBookParamsModel? model) {
    List<String> headerTitle = [
      'mothers_name'.tr,
      'childs_name'.tr,
      'age'.tr,
      'estimate_workshop'.tr,
    ];
    var year = 'year'.tr;
    List<String> header = [
      reportCardHeader?.parentUserFullName ?? '',
      reportCardHeader?.childUserFullName ?? '',
      (reportCardHeader?.childFullAge ?? ' '),
      reportCardHeader?.workShopCategoryTitle ?? '',
    ];
    List<WorkBookDetailReviews> reviews = workShopReportCardDetails
            ?.map((e) => WorkBookDetailReviews(
                question: e.question ?? '',
                id: e.questionId ?? 0,
                comment: e.answer ?? '',
                fileDataId: e.solutionFileId,
                answerRate: e.answerRate?.toString() ?? ''))
            .toList() ??
        [];

    var workShopName = reportCardHeader?.workShopCategoryTitle ?? '';
    var one = lastWorkShopReportCard?.firstRateAnswersCount?.toString() ?? '';
    var two = lastWorkShopReportCard?.secondRateAnswersCount?.toString() ?? '';
    var three = lastWorkShopReportCard?.thirdRateAnswersCount?.toString() ?? '';
    var allQCount = lastWorkShopReportCard?.allQuestionsCount?.toString() ?? '';
    var workShopWorkBookTitle =
        '${'chil_capability_in'.tr} $workShopName : $three ${'from'.tr} $allQCount';

    var typeOne = 'بر اساس ارزیابی که شما از توانمندی های  ';
    var typeTwo = ' خود داشته اید،';
    var typeTree = "توانمندی را تا حدی انجام می دهد و ";
    var typeFure = 'هیچ توانمندی نیست  که هنوز موفق به انجام نشده باشد.';
    var typefive = ' توانمندی   که هنوز موفق به انجام نشده باشد.';
    var typeSix = '';
    if (one == "0") {
      typeSix = typeFure;
    } else {
      typeSix = '${one} ${typefive}';
    }
    var workShopDescription =
        '$typeOne $workShopName ${typeTwo} ${'between'.tr} $allQCount ${'ability'.tr} $workShopName ${'your_child_has_mastered_more'.tr} $three ${'your_child_has_mastered_ok'.tr}. $two ${typeTree} ${typeSix}';
    int maxValue = lastWorkShopSubCategoryReportCards?.fold(
            0,
            (previousValue, element) =>
                (previousValue ?? 0) +
                (element.allQuestionsCount?.toInt() ?? 0)) ??
        0;
    lastWorkShopSubCategoryReportCards?.sort((a, b) =>
        (int.tryParse(a.workShopDictionary!.keys.first) ?? 0)
            .compareTo(num.tryParse(b.workShopDictionary!.keys.first) ?? 0));
    firstWorkShopSubCategoryReportCards?.sort((a, b) =>
        (int.tryParse(a.workShopDictionary!.keys.first) ?? 0)
            .compareTo(num.tryParse(b.workShopDictionary!.keys.first) ?? 0));
    List<String> names = lastWorkShopSubCategoryReportCards
            ?.map((e) => e.workShopDictionary?.values.first.toString() ?? '')
            .toList() ??
        [];
    print('names is $names');
    List<String> lableData = [];
    List<double> firstValues = firstWorkShopSubCategoryReportCards?.map((e) {
          int all = (e.allQuestionsCount ?? 0).toInt();
          int correct = (e.thirdRateAnswersCount ?? 0).toInt();
          lableData.add('$correct ${'from'.tr} $all');
          return (maxValue * correct) / all;
        }).toList() ??
        [];
    print('first values is $firstValues');

    List<double> lastValues = lastWorkShopSubCategoryReportCards?.map((e) {
          int all = (e.allQuestionsCount ?? 0).toInt();
          int correct = (e.thirdRateAnswersCount ?? 0).toInt();
          lableData.add('$correct ${'from'.tr} $all');
          return (maxValue * correct) / all;
        }).toList() ??
        [];
    print('last values is $lastValues');

    print('label data is $lableData');
    print('max value is $maxValue');
    var cards = generalReportCards ?? [];
    cards.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    var totalWorkBookTitle =
        '${'comprehensive_assessment'.tr}: %s ${'area'.tr} ${'from'.tr} %s ${'area'.tr}';

    List<List<WorkBookTableModel>> tableData = [];
    generalReportCards?.forEach((e) {
      List<WorkBookTableModel> worksShops = [];
      e.workShopReportCards?.forEach((element) {
        worksShops.add(
          WorkBookTableModel(
            id: element.workShopDictionary?.categoryId?.toString() ?? '0',
            previousThree: 0,
            three: element.thirdRateAnswersCount ?? 0,
            count: (element.allQuestionsCount ?? 0).toString(),
          ),
        );
      });
      tableData.add(worksShops);
    });

    ChartDataModel workShopChartData = ChartDataModel(
        maxValue: maxValue,
        name: names,
        values: [firstValues, lastValues],
        lableData: lableData);

    var userParticipateAssessmentCount =
        workShopReportCard?.userParticipateAssessmentCount ?? 0;
    var counter = '${'assessment'.tr} $userParticipateAssessmentCount';
    return WorkBookDetailUiModel(
      headerTitle: headerTitle,
      header: header,
      reviews: reviews,
      categories: workShopCategories,
      workShop: workShopName,
      workShopWorkBookTitle: workShopWorkBookTitle,
      workShopWorkBookDescription: workShopDescription,
      counter: counter,
      workShpChartModel: workShopChartData,
      cards: cards,
      totalWorkBookTitle: totalWorkBookTitle,
      tableData: tableData,
    );
  }
}

extension WorkShopReportExtension on List<WorkShopReportCard>? {
  int get getMaxValue =>
      this?.fold(
          0,
          (previousValue, element) =>
              (previousValue ?? 0) > (element.allQuestionsCount ?? 0)
                  ? previousValue
                  : (element.allQuestionsCount ?? 0)) ??
      0;
}

class WorkShopCategory {
  final String name, id;

  const WorkShopCategory({
    required this.name,
    required this.id,
  });
}

class Accordion {
  final String title;
  final int assessmentQuestionId;
  final String workMethod;
  final String learningOpportunity;
  final String requiredTools;
  final int id;
  bool isExpanded;

  Accordion(
      {required this.title,
      required this.assessmentQuestionId,
      required this.workMethod,
      required this.learningOpportunity,
      required this.requiredTools,
      required this.id,
      required this.isExpanded});

  factory Accordion.fromJson(Map<String, dynamic> json) {
    return Accordion(
        title: json['title'],
        assessmentQuestionId: json['assessmentQuestionId'],
        workMethod: json['workMethod'],
        learningOpportunity: json['learningOpportunity'],
        requiredTools: json['requiredTools'],
        id: json['id'],
        isExpanded: false);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'assessmentQuestionId': assessmentQuestionId,
      'workMethod': workMethod,
      'learningOpportunity': learningOpportunity,
      'requiredTools': requiredTools,
      'id': id,
    };
  }
}

List<Accordion> fluttrActivitiesFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => Accordion.fromJson(json)).toList();
}
