import 'dart:convert';

import 'package:my_ios_app/data/serializer/child/parentCategoryFiles.dart';

CategoryDetailResponse categoryDetailResponseFromJson(String str) =>
    CategoryDetailResponse.fromJson(json.decode(str));

String categoryDetailResponseToJson(CategoryDetailResponse data) =>
    json.encode(data.toJson());

class CategoryDetailResponse {
  CategoryDetailResponse({
    this.title,
    this.description,
    this.subCategories,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
    this.parentCategoryFiles,
  });

  CategoryDetailResponse.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories?.add(SubCategories.fromJson(v));
      });
    }
    id = json['id'];
    parentCategoryFiles = json["parentCategoryFiles"] != null
        ? List<ParentCategoryFiles>.from(json["parentCategoryFiles"]!
            .map((x) => ParentCategoryFiles.fromJson(x)))
        : null;
    statusCode = json['statusCode'];
  }

  String? title;
  String? description;
  List<SubCategories>? subCategories;
  List<ParentCategoryFiles>? parentCategoryFiles;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
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
