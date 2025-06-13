import 'dart:convert';
ChangePasswordResponse changePasswordResponseFromJson(String str) => ChangePasswordResponse.fromJson(json.decode(str));
String changePasswordResponseToJson(ChangePasswordResponse data) => json.encode(data.toJson());
class ChangePasswordResponse {
  ChangePasswordResponse({
      this.isSuccess, 
      this.message,});

  ChangePasswordResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }
  bool? isSuccess;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    return map;
  }

}