import 'dart:convert';

UserCalendarResponse userCalendarResponseFromJson(String str) =>
    UserCalendarResponse.fromJson(json.decode(str));

List<CalendarItems> defaultCalendarFromJson(String str) =>
    List<CalendarItems>.from(
        json.decode(str).map((x) => CalendarItems.fromJson(x)));

String userCalendarResponseToJson(UserCalendarResponse data) =>
    json.encode(data.toJson());

class UserCalendarResponse {
  UserCalendarResponse({
    this.packageId,
    this.calendarItems,
  });

  UserCalendarResponse.fromJson(dynamic json) {
    packageId = json['packageId'];
    if (json['calendarItems'] != null) {
      calendarItems = [];
      json['calendarItems'].forEach((v) {
        calendarItems?.add(CalendarItems.fromJson(v));
      });
    }
  }

  num? packageId;
  List<CalendarItems>? calendarItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packageId'] = packageId;
    if (calendarItems != null) {
      map['calendarItems'] = calendarItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CalendarItems calendarItemsFromJson(String str) =>
    CalendarItems.fromJson(json.decode(str));

String calendarItemsToJson(CalendarItems data) => json.encode(data.toJson());

class CalendarItems {
  CalendarItems({
    this.dayOfWeek,
    this.parentCategory,
    this.assessmentNumber,
    this.nextAssessmentDate,
    this.userChildWorkShopId,
    this.workShopId,
    this.colorNumber,
  });

  CalendarItems.fromJson(dynamic json) {
    dayOfWeek = json['dayOfWeek'];
    parentCategory = json['parentCategory'] != null
        ? ParentCategory.fromJson(json['parentCategory'])
        : null;
    assessmentNumber = json['assessmentNumber'];
    colorNumber = json['colorNumber'];
    userChildWorkShopId = json['userChildWorkShopId'];
    workShopId = json['workShopId'];
    nextAssessmentDate = json['nextAssessmentDate'] != null
        ? DateTime.tryParse(json['nextAssessmentDate'])?.toLocal()
        : null;
  }

  num? dayOfWeek;
  ParentCategory? parentCategory;
  dynamic userChildWorkShopId;
  int? workShopId;
  num? assessmentNumber;
  DateTime? nextAssessmentDate;
  String? colorNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayOfWeek'] = dayOfWeek;
    if (parentCategory != null) {
      map['parentCategory'] = parentCategory?.toJson();
    }
    map['assessmentNumber'] = assessmentNumber;
    map['nextAssessmentDate'] = nextAssessmentDate;
    return map;
  }
}

ParentCategory parentCategoryFromJson(String str) =>
    ParentCategory.fromJson(json.decode(str));

String parentCategoryToJson(ParentCategory data) => json.encode(data.toJson());

class ParentCategory {
  ParentCategory({
    this.title,
    this.description,
    this.colorNumber,
    this.isActive,
    this.id,
  });

  ParentCategory.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    colorNumber = json['colorNumber'];
    isActive = json['isActive'];
    id = json['id'];
  }

  String? title;
  String? description;
  String? colorNumber;
  bool? isActive;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['isActive'] = isActive;
    map['id'] = id;
    return map;
  }
}
