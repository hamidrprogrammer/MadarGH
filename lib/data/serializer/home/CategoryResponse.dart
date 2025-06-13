// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:my_ios_app/data/serializer/child/parentCategoryFiles.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  dynamic files;
  dynamic subCategories;
  dynamic workShops;
  String? title;
  String? colorNumber;
  String? description;
  List<ParentCategoryFiles>? parentCategoryFiles;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Category({
    this.files,
    this.subCategories,
    this.workShops,
    this.title,
    this.colorNumber,
    this.description,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
    this.parentCategoryFiles,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        files: json["files"],
        subCategories: json["subCategories"],
        workShops: json["workShops"],
        title: json["title"],
        colorNumber: json["colorNumber"],
        description: json["description"],
        parentCategoryFiles: json["parentCategoryFiles"] != null
            ? List<ParentCategoryFiles>.from(json["parentCategoryFiles"]?.map((x) => ParentCategoryFiles.fromJson(x)))
            : null,
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]?.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]?.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "files": files,
        "subCategories": subCategories,
        "workShops": workShops,
        "title": title,
        "description": description,
        "id": id,
       "errorMessages": errorMessages?.map((x) => x).toList() ?? [],
"statusCode": statusCode,
"successfulMessages": successfulMessages?.map((x) => x).toList() ?? [],
      };
}
