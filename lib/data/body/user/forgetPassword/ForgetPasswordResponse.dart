import 'dart:convert';
ForgetPasswordResponse forgetPasswordResponseFromJson(String str) => ForgetPasswordResponse.fromJson(json.decode(str));
String forgetPasswordResponseToJson(ForgetPasswordResponse data) => json.encode(data.toJson());
class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  ForgetPasswordResponse.fromJson(dynamic json) {
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
      this.verifyCode,});

  Data.fromJson(dynamic json) {
    mobile = json['mobile'];
    verifyCode = json['verifyCode'];
  }
  String? mobile;
  num? verifyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['verifyCode'] = verifyCode;
    return map;
  }

}