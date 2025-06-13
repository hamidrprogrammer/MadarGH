// To parse this JSON data, do
//
//     final childsItem = childsItemFromJson(jsonString);

import 'dart:convert';

import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/presentation/uiModel/assessmeny/AssessmentParamsModel.dart';

List<ChildsItem> childsItemFromJson(String str) =>
    List<ChildsItem>.from(json.decode(str).map((x) => ChildsItem.fromJson(x)));

String childsItemToJson(List<ChildsItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildsItem {
  dynamic parentUser;
  String? avatar;
  String? childFirstName;
  String? childAge;
  int? gender;
  UserAvatar? childPicture;
  String? childLastName;
  DateTime? birtDate;
  String? parentUserId;
  dynamic mobileNumber;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  ChildsItem({
    this.parentUser,
    this.avatar,
    this.childAge,
    this.gender,
    this.childPicture,
    this.childFirstName,
    this.childLastName,
    this.birtDate,
    this.parentUserId,
    this.mobileNumber,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory ChildsItem.fromJson(Map<String, dynamic> json) => ChildsItem(
        parentUser: json["parentUser"],
        avatar: json["avatar"],
    gender: json["gender"],
        childAge: json["childFullAge"],
        childFirstName: json["childFirstName"],
        childLastName: json["childLastName"],
        childPicture: json["childPicture"] != null
            ? UserAvatar.fromJson(json["childPicture"])
            : null,
        birtDate:
            json["birtDate"] == null ? null : DateTime.parse(json["birtDate"]),
        parentUserId: json["parentUserId"],
        mobileNumber: json["mobileNumber"],
        id: json["id"],
        errorMessages: json["errorMessages"] == null
            ? []
            : List<dynamic>.from(json["errorMessages"]!.map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages: json["successfulMessages"] == null
            ? []
            : List<dynamic>.from(json["successfulMessages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "parentUser": parentUser,
        "avatar": avatar,
        "childFirstName": childFirstName,
        "childLastName": childLastName,
        "birtDate": birtDate?.toIso8601String(),
        "parentUserId": parentUserId,
        "mobileNumber": mobileNumber,
        "id": id,
"errorMessages": errorMessages?.map((x) => x).toList() ?? [],
"statusCode": statusCode,
"successfulMessages": successfulMessages?.map((x) => x).toList() ?? [],
      };

// static createAssessmentParam(String course) => AssessmentParamsModel(name: '${childFirstName} ${}', id: id?.toString() ??'', course: course);
}

extension ChildItemExtension on ChildsItem {
  AssessmentParamsModel getAssessmentParam({required String workShopId, course}) {
    return AssessmentParamsModel(
      name: childFirstName ?? '',
      id: workShopId,
      childId: id?.toString() ?? '',
      workShopId: workShopId,
      course: course,
    );
  }
}
