// To parse this JSON data, do
//
//     final workBook = workBookFromJson(jsonString);

import 'dart:convert';

List<WorkBook> workBooksFromJson(String str) =>
    List<WorkBook>.from(json.decode(str).map((x) => WorkBook.fromJson(x)));

String workBooksToJson(List<WorkBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkBook {
  String? workShopTitle;
  String? packageAgeDomain;

  String? workShopFileContent;
  int? workShopId;
  num? toAgeDomain;
  num? fromAgeDomain;
  WorkBook({
    this.workShopTitle,
    this.packageAgeDomain,
    this.workShopId,
    this.workShopFileContent,
    this.toAgeDomain,
    this.fromAgeDomain,
  });

  factory WorkBook.fromJson(Map<String, dynamic> json) => WorkBook(
        workShopTitle: json["workShopTitle"],
        packageAgeDomain: json["packageAgeDomain"],
        workShopId: json["workShopId"],
        workShopFileContent: json["workShopFileContent"],
        toAgeDomain: json["toAgeDomain"],
        fromAgeDomain: json["fromAgeDomain"],
      );

  Map<String, dynamic> toJson() => {
        "workShopTitle": workShopTitle,
        "packageAgeDomain": packageAgeDomain,
        "workShopFileContent": workShopFileContent,
        "workShopId": workShopId,
        'fromAgeDomain': fromAgeDomain,
        "toAgeDomain": toAgeDomain
      };
}
