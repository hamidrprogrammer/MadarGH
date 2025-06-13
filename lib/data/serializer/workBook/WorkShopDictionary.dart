// To parse this JSON data, do
//
//     final workShopDictionary = workShopDictionaryFromJson(jsonString);

import 'dart:convert';

WorkShopDictionary workShopDictionaryFromJson(String str) => WorkShopDictionary.fromJson(json.decode(str));

String workShopDictionaryToJson(WorkShopDictionary data) => json.encode(data.toJson());

class WorkShopDictionary {
  int? workShopId;
  int? categoryId;
  String? name;

  WorkShopDictionary({
    this.workShopId,
    this.categoryId,
    this.name,
  });

  factory WorkShopDictionary.fromJson(Map<String, dynamic> json) => WorkShopDictionary(
    workShopId: json["item1"],
    categoryId: json["item2"],
    name: json["item3"],
  );

  Map<String, dynamic> toJson() => {
    "item1": workShopId,
    "item2": categoryId,
    "item3": name,
  };
}
