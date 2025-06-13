import 'dart:convert';

// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

Meeting responseFromJson(String str) => Meeting.fromJson(json.decode(str));
Meeting getUserMettingResponseFromJson(String str) =>
    Meeting.fromJson(json.decode(str));
String responseToJson(Meeting data) => json.encode(data.toJson());

class Meeting {
  String? skyRoomLink;
  String? executionDate;
  String? executionStartTime;
  String? executionEndTime;
  String? description;
  String? parentUserId;
  String? followerUserId;
  String? childAge;
  String? userMobile;
  String? userFullName;
  String? timeUntilExecution;
  bool isCanceled;
  int id;
  List<String> errorMessages;
  int statusCode;
  List<String> successfulMessages;

  Meeting({
    this.skyRoomLink,
    this.executionDate,
    this.executionStartTime,
    this.executionEndTime,
    this.description,
    this.parentUserId,
    this.followerUserId,
    this.childAge,
    this.userMobile,
    this.userFullName,
    this.timeUntilExecution,
    required this.isCanceled,
    required this.id,
    required this.errorMessages,
    required this.statusCode,
    required this.successfulMessages,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        skyRoomLink: json["skyRoomLink"],
        executionDate: json["executionDate"],
        executionStartTime: json["executionStartTime"],
        executionEndTime: json["executionEndTime"],
        description: json["description"],
        parentUserId: json["parentUserId"],
        followerUserId: json["followerUserId"],
        childAge: json["childAge"],
        userMobile: json["userMobile"],
        userFullName: json["userFullName"],
        timeUntilExecution: json["timeUntilExecution"],
        isCanceled: json["isCanceled"],
        id: json["id"],
        errorMessages: List<String>.from(json["errorMessages"].map((x) => x)),
        statusCode: json["statusCode"],
        successfulMessages:
            List<String>.from(json["successfulMessages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "skyRoomLink": skyRoomLink,
        "executionDate": executionDate,
        "executionStartTime": executionStartTime,
        "executionEndTime": executionEndTime,
        "description": description,
        "parentUserId": parentUserId,
        "followerUserId": followerUserId,
        "childAge": childAge,
        "userMobile": userMobile,
        "userFullName": userFullName,
        "timeUntilExecution": timeUntilExecution,
        "isCanceled": isCanceled,
        "id": id,
        "errorMessages": List<dynamic>.from(errorMessages.map((x) => x)),
        "statusCode": statusCode,
        "successfulMessages":
            List<dynamic>.from(successfulMessages.map((x) => x)),
      };
}

List<Supervisors> getAllSupervisorsOfUserChildrenJson(String str) {
  List<dynamic> jsonData = json.decode(str); // Decode JSON string to list
  return jsonData
      .map((supervisor) => Supervisors.fromJson(supervisor))
      .toList();
}

class Supervisors {
  String? FirstName;
  String? LastName;
  String? Mobile;
  String? ChildFirstName;
  String? ChildLastName;

  Supervisors({
    this.FirstName,
    this.LastName,
    this.Mobile,
    this.ChildFirstName,
    this.ChildLastName,
  });

  factory Supervisors.fromJson(Map<String, dynamic> json) => Supervisors(
        FirstName: json["firstName"],
        LastName: json["lastName"],
        Mobile: json["mobile"],
        ChildFirstName: json["childFirstName"],
        ChildLastName: json["childLastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": FirstName,
        "lastName": LastName,
        "childFirstName": ChildFirstName,
        "childLastName": ChildLastName,
        "mobile": Mobile,
      };
}
