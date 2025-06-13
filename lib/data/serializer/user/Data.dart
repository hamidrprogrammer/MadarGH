import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.firstName, 
      this.lastName, 
      this.mobile, 
      this.password, 
      this.rePassword, 
      this.isSuccess, 
      this.statusMessage, 
      this.terms, 
      this.subscribeId,});

  Data.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
    rePassword = json['rePassword'];
    isSuccess = json['isSuccess'];
    statusMessage = json['statusMessage'];
    terms = json['terms'];
    subscribeId = json['subscribeId'];
  }
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;
  String? rePassword;
  bool? isSuccess;
  String? statusMessage;
  bool? terms;
  num? subscribeId;
Data copyWith({  String? firstName,
  String? lastName,
  String? mobile,
  String? password,
  String? rePassword,
  bool? isSuccess,
  String? statusMessage,
  bool? terms,
  num? subscribeId,
}) => Data(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  mobile: mobile ?? this.mobile,
  password: password ?? this.password,
  rePassword: rePassword ?? this.rePassword,
  isSuccess: isSuccess ?? this.isSuccess,
  statusMessage: statusMessage ?? this.statusMessage,
  terms: terms ?? this.terms,
  subscribeId: subscribeId ?? this.subscribeId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['mobile'] = mobile;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['isSuccess'] = isSuccess;
    map['statusMessage'] = statusMessage;
    map['terms'] = terms;
    map['subscribeId'] = subscribeId;
    return map;
  }

}