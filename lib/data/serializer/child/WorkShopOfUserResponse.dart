import 'dart:convert';

WorkShopOfUserResponse workShopOfUserResponseFromJson(String str) =>
    WorkShopOfUserResponse.fromJson(json.decode(str));

String workShopOfUserResponseToJson(WorkShopOfUserResponse data) =>
    json.encode(data.toJson());

class WorkShopOfUserResponse {
  WorkShopOfUserResponse({
    this.activeUserChildWorkShops,
    this.inActiveUserChildWorkShops,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  WorkShopOfUserResponse.fromJson(dynamic json) {
    if (json['activeUserChildWorkShops'] != null) {
      activeUserChildWorkShops = [];
      json['activeUserChildWorkShops'].forEach((v) {
        v['isActive'] = true;
        activeUserChildWorkShops?.add(ChildWorkShops.fromJson(v));
      });
    }
    if (json['inActiveUserChildWorkShops'] != null) {
      inActiveUserChildWorkShops = [];
      json['inActiveUserChildWorkShops'].forEach((v) {
        v['isActive'] = false;
        inActiveUserChildWorkShops?.add(ChildWorkShops.fromJson(v));
      });
    }
    id = json['id'];
    statusCode = json['statusCode'];
  }

  List<ChildWorkShops>? activeUserChildWorkShops;
  List<ChildWorkShops>? inActiveUserChildWorkShops;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (activeUserChildWorkShops != null) {
      map['activeUserChildWorkShops'] =
          activeUserChildWorkShops?.map((v) => v.toJson()).toList();
    }
    if (inActiveUserChildWorkShops != null) {
      map['inActiveUserChildWorkShops'] =
          inActiveUserChildWorkShops?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ChildWorkShops childWorkShopsShopsFromJson(String str) =>
    ChildWorkShops.fromJson(json.decode(str));

String childWorkShopsShopsToJson(ChildWorkShops data) =>
    json.encode(data.toJson());

class ChildWorkShops {
  ChildWorkShops({
    this.workShopTitle,
    this.parentCategoryId,
    this.packageAgeDomain,
    this.questionCount,
    this.questionKind,
    this.id,
    this.workShopId,
    this.statusCode,
    this.isActive,
    this.InActiveReasonId,
    this.InActiveReason
  });

  ChildWorkShops.fromJson(dynamic json) {
    id = json['id'];
    workShopTitle = json['workShopTitle'];
    packageAgeDomain = json['packageAgeDomain'];
    questionCount = json['questionCount'];
    questionKind = json['questionKind'];
    workShopId = json['workShopId'];
    parentCategoryId = json['parentCategoryId'];
    statusCode = json['statusCode'];
    isActive = json['isActive'];
    InActiveReasonId = json['inActiveReasonId'];
    InActiveReason = json['inActiveReason'];
  }

  String? workShopTitle;
  String? packageAgeDomain;
  num? questionCount;
  dynamic questionKind;
  num? id;
  num? workShopId;
  num? parentCategoryId;
  num? statusCode;
  bool? isActive;
  num? InActiveReasonId;
  String? InActiveReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workShopTitle'] = workShopTitle;
    map['parentCategoryId'] = parentCategoryId;
    map['packageAgeDomain'] = packageAgeDomain;
    map['questionCount'] = questionCount;
    map['questionKind'] = questionKind;
    map['id'] = id;
    map['workShopId'] = workShopId;
    map['statusCode'] = statusCode;
    return map;
  }
}
