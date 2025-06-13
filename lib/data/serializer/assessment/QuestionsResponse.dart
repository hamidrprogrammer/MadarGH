// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';

List<Questions> questionsFromJson(String str) =>
    List<Questions>.from(json.decode(str).map((x) => Questions.fromJson(x)));

String questionsToJson(List<Questions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Questions {
  int? categoryId;
  String? categoryTitle;
  List<Question>? questions;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Questions({
    this.categoryId,
    this.categoryTitle,
    this.questions,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        categoryId: json["categoryId"],
        categoryTitle: json["categoryTitle"],
        questions: (json["questions"] as List?)
                ?.map((x) => Question.fromJson(x))
                .toList() ??
            [],
        id: json["id"],
        errorMessages: (json["errorMessages"] as List?)?.toList() ?? [],
        statusCode: json["statusCode"],
        successfulMessages:
            (json["successfulMessages"] as List?)?.toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryTitle": categoryTitle,
        "questions": questions?.map((x) => x.toJson()).toList() ?? [],
        "id": id,
        "errorMessages": errorMessages ?? [],
        "statusCode": statusCode,
        "successfulMessages": successfulMessages ?? [],
      };
}

class Question {
  int? questionId;
  String? questionTitle;
  UserAvatar? questionPicture;
  List<Option>? options;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Question({
    this.questionId,
    this.questionTitle,
    this.questionPicture,
    this.options,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["questionId"],
        questionTitle: json["questionTitle"],
        questionPicture: json["questionPicture"] != null
            ? UserAvatar.fromJson(json["questionPicture"])
            : null,
        options: (json["options"] as List?)
                ?.map((x) => Option.fromJson(x))
                .toList() ??
            [],
        id: json["id"],
        errorMessages: (json["errorMessages"] as List?)?.toList() ?? [],
        statusCode: json["statusCode"],
        successfulMessages:
            (json["successfulMessages"] as List?)?.toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionTitle": questionTitle,
        "questionPicture": questionPicture?.toJson(),
        "options": options?.map((x) => x.toJson()).toList() ?? [],
        "id": id,
        "errorMessages": errorMessages ?? [],
        "statusCode": statusCode,
        "successfulMessages": successfulMessages ?? [],
      };
}

class Option {
  int? optionId;
  String? optionTitle;
  int? rate;
  int? id;
  List<dynamic>? errorMessages;
  int? statusCode;
  List<dynamic>? successfulMessages;

  Option({
    this.optionId,
    this.optionTitle,
    this.rate,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: json["optionId"],
        optionTitle: json["optionTitle"],
        rate: json["rate"],
        id: json["id"],
        errorMessages: (json["errorMessages"] as List?)?.toList() ?? [],
        statusCode: json["statusCode"],
        successfulMessages:
            (json["successfulMessages"] as List?)?.toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        "optionId": optionId,
        "optionTitle": optionTitle,
        "rate": rate,
        "id": id,
        "errorMessages": errorMessages ?? [],
        "statusCode": statusCode,
        "successfulMessages": successfulMessages ?? [],
      };
}
