import 'dart:convert';

import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
    this.isActive,
    this.activationCode,
    this.firstName,
    this.lastName,
    this.mobile,
    this.userName,
    this.token,
    this.newPassword,
    this.confirmNewPasswod,
    this.birtDay,
    this.avatarId,
    this.refreshToken,
    this.id,
  });

  User.fromJson(dynamic json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    isActive = json['isActive'];
    refreshToken = json['refreshToken'];
    activationCode = json['activationCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    userName = json['userName'];
    token = json['token'];
    newPassword = json['newPassword'];
    confirmNewPasswod = json['confirmNewPasswod'];
    birtDay = json['birtDay'];
    avatarId = json['avatarId'];
    avatar =
        json['avatar'] != null ? UserAvatar.fromJson(json['avatar']) : null;
    id = json['id'];
  }
  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;
  bool? isActive;
  String? activationCode;
  String? refreshToken;
  String? firstName;
  String? lastName;
  String? mobile;
  String? userName;
  String? token;
  String? newPassword;
  String? confirmNewPasswod;
  String? birtDay;
  String? avatarId;
  UserAvatar? avatar;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    map['password'] = password;
    map['avatar'] = avatar;
    map['confirmPassword'] = confirmPassword;
    map['isActive'] = isActive;
    map['activationCode'] = activationCode;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['mobile'] = mobile;
    map['refreshToken'] = refreshToken;
    map['userName'] = userName;
    map['token'] = token;
    map['newPassword'] = newPassword;
    map['confirmNewPasswod'] = confirmNewPasswod;
    map['birtDay'] = birtDay;
    map['avatarId'] = avatarId;
    map['id'] = id;
    return map;
  }
}
