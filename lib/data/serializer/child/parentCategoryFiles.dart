// To parse this JSON data, do
//
//     final parentCategoryFiles = parentCategoryFilesFromJson(jsonString);

import 'dart:convert';

import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';

List<ParentCategoryFiles> parentCategoryFilesFromJson(String str) => List<ParentCategoryFiles>.from(json.decode(str).map((x) => ParentCategoryFiles.fromJson(x)));

String parentCategoryFilesToJson(List<ParentCategoryFiles> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParentCategoryFiles {
  dynamic category;
  UserAvatar? file;
  int? categoryId;
  String? fileId;
  int? location;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ParentCategoryFiles({
    this.category,
    this.file,
    this.categoryId,
    this.fileId,
    this.location,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ParentCategoryFiles.fromJson(Map<String, dynamic> json) => ParentCategoryFiles(
    category: json["category"],
    file: json["file"] == null ? null : UserAvatar.fromJson(json["file"]),
    categoryId: json["categoryId"],
    fileId: json["fileId"],
    location: json["location"],
    id: json["id"],
    errorMessages: json["errorMessages"] == null ? [] : List<dynamic>.from(json["errorMessages"]?.map((x) => x)),
    statusCode: json["statusCode"],
    successfulMessages: json["successfulMessages"] == null ? [] : List<dynamic>.from(json["successfulMessages"]?.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "file": file?.toJson(),
    "categoryId": categoryId,
    "fileId": fileId,
    "location": location,
    "id": id,
   "errorMessages": errorMessages?.map((x) => x).toList() ?? [],
"statusCode": statusCode,
"successfulMessages": successfulMessages?.map((x) => x).toList() ?? [],
  };
}

