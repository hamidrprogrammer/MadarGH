import 'dart:convert';

WorkShopReportItem workShopReportItemFromJson(String str) =>
    WorkShopReportItem.fromJson(json.decode(str));

String workShopReportItemToJson(WorkShopReportItem data) =>
    json.encode(data.toJson());

class WorkShopReportItem {
  WorkShopReportItem({
    this.workShopDictionary,
    this.allQuestionsCount,
    this.firstRateAnswersCount,
    this.secondRateAnswersCount,
    this.thirdRateAnswersCount,
    this.userParticipateAssessmentCount,
    this.id,
  });

  WorkShopReportItem.fromJson(dynamic json) {
    workShopDictionary = json["categoryDictionary"] != null
        ? Map.from(json["categoryDictionary"]!)
            .map((k, v) => MapEntry<String, String>(k, v))
        : null;
    allQuestionsCount = json['allQuestionsCount'];
    firstRateAnswersCount = json['firstRateAnswersCount'];
    secondRateAnswersCount = json['secondRateAnswersCount'];
    thirdRateAnswersCount = json['thirdRateAnswersCount'];
    userParticipateAssessmentCount = json['userParticipateAssessmentCount'];
    id = json['id'];
  }

  Map<String, String>? workShopDictionary;
  num? allQuestionsCount;
  num? firstRateAnswersCount;
  num? secondRateAnswersCount;
  num? thirdRateAnswersCount;
  num? userParticipateAssessmentCount;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allQuestionsCount'] = allQuestionsCount;
    map['firstRateAnswersCount'] = firstRateAnswersCount;
    map['secondRateAnswersCount'] = secondRateAnswersCount;
    map['thirdRateAnswersCount'] = thirdRateAnswersCount;
    map['userParticipateAssessmentCount'] = userParticipateAssessmentCount;
    map['id'] = id;
    return map;
  }
}
