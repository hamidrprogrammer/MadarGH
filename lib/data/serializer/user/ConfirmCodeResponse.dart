import 'dart:convert';
ConfirmCodeResponse confirmCodeResponseFromJson(String str) => ConfirmCodeResponse.fromJson(json.decode(str));
String confirmCodeResponseToJson(ConfirmCodeResponse data) => json.encode(data.toJson());
class ConfirmCodeResponse {
  ConfirmCodeResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  ConfirmCodeResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.mobile, 
      this.verifyCode, 
      this.password, 
      this.confirmPassword,});

  Data.fromJson(dynamic json) {
    mobile = json['mobile'];
    verifyCode = json['verifyCode'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }
  String? mobile;
  num? verifyCode;
  String? password;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['verifyCode'] = verifyCode;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    return map;
  }

}