import 'dart:convert';

import 'package:get/get.dart';

import 'ImageResponse.dart';

List<ChildPackage> childPackageFromJson(String str) => List<ChildPackage>.from(
    json.decode(str).map((x) => ChildPackage.fromJson(x)));


class ChildPackage {
  String? childName;
  ImageResponse? childPicture;
  Package? packages;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ChildPackage({
    this.childName,
    this.childPicture,
    this.packages,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ChildPackage.fromJson(Map<String, dynamic> json) => ChildPackage(
        childName: json["childName"],
        childPicture: json["childPicture"] != null
            ? imageResponseFromJson(jsonEncode(json["childPicture"]))
            : null,
        packages: json["package"] == null
            ? null
            : Package.fromJson(json["package"]),
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]?.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]?.map((x) => x)),
      );

}

class Package {
  String? title;
  String? description;
  bool? isActive;
  int? ageDomainId;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Package({
    this.title,
    this.description,
    this.isActive,
    this.ageDomainId,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        title: json["title"],
        description: json["description"],
        isActive: json["isActive"],
        ageDomainId: json["ageDomainId"],
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
        "title": title,
        "description": description,
        "isActive": isActive,
        "ageDomainId": ageDomainId,
        "id": id,
       "errorMessages": errorMessages?.map((x) => x).toList() ?? [],
"statusCode": statusCode,
"successfulMessages": successfulMessages?.map((x) => x).toList() ?? [],
      };
}

extension ChildListPackageExtension on List<ChildPackage> {
  ChildPackage? getChildPackage(String? subscribeId) {
    return firstWhereOrNull((element) => element.packages?.id?.toString() == subscribeId);
  }
}
