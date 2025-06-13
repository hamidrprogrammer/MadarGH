// To parse this JSON data, do
//
//     final subscribeItem = subscribeItemFromJson(jsonString);

import 'dart:convert';

import 'package:my_ios_app/data/serializer/child/parentCategoryFiles.dart';

List<SubscribeItem> subscribesResponseFromJson(String str) =>
    List<SubscribeItem>.from(
        json.decode(str).map((x) => SubscribeItem.fromJson(x)));

class SubscribeItem {
  dynamic ageDomain;
  String? title;
  String? description;
  bool? isActive;
  int? ageDomainId;
  int? id;
  List<ParentCategoryFiles>? parentCategoryFiles;

  SubscribeItem({
    this.ageDomain,
    this.title,
    this.description,
    this.isActive,
    this.ageDomainId,
    this.id,
    this.parentCategoryFiles
  });

  factory SubscribeItem.fromJson(Map<String, dynamic> json) => SubscribeItem(
        ageDomain: json["ageDomain"],
        title: json["title"],
        description: json["description"],
        isActive: json["isActive"],
        ageDomainId: json["ageDomainId"],
        id: json["id"],
        parentCategoryFiles: json["packageFiles"] == null
            ? []
            : List<ParentCategoryFiles>.from(json["packageFiles"]?.map((x) => ParentCategoryFiles.fromJson(x))),
      );

}

extension SubscribeItemExtension on SubscribeItem {
  bool isValidForChild(String? childPackageId) =>
      id?.toString() == childPackageId;
}
