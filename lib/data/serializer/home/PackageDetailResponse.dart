import 'dart:convert';

PackageDetailResponse packageDetailResponseFromJson(String str) =>
    PackageDetailResponse.fromJson(json.decode(str));

String packageDetailResponseToJson(PackageDetailResponse data) =>
    json.encode(data.toJson());

class PackageDetailResponse {
  PackageDetailResponse({
    this.title,
    this.workShops,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  PackageDetailResponse.fromJson(dynamic json) {
    title = json['title'];
    if (json['workShops'] != null) {
      workShops = [];
      json['workShops'].forEach((v) {
        workShops?.add(WorkShops.fromJson(v));
      });
    }
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? title;
  List<WorkShops>? workShops;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (workShops != null) {
      map['workShops'] = workShops?.map((v) => v.toJson()).toList();
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

WorkShops workShopsFromJson(String str) => WorkShops.fromJson(json.decode(str));

String workShopsToJson(WorkShops data) => json.encode(data.toJson());

class WorkShops {
  WorkShops({
    this.title,
    this.description,
    this.subCategories,
    this.id,
    this.parentCategoryId,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  WorkShops.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories?.add(SubCategories.fromJson(v));
      });
    }
    id = json['id'];
    parentCategoryId = json['parentCategoryId'];

    statusCode = json['statusCode'];
  }

  String? title;
  String? description;
  List<SubCategories>? subCategories;
  num? id;
  num? parentCategoryId;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['parentCategoryId'] = parentCategoryId;
    if (subCategories != null) {
      map['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
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

SubCategories subCategoriesFromJson(String str) =>
    SubCategories.fromJson(json.decode(str));

String subCategoriesToJson(SubCategories data) => json.encode(data.toJson());

class SubCategories {
  SubCategories({
    this.title,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  SubCategories.fromJson(dynamic json) {
    title = json['title'];
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? title;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
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
