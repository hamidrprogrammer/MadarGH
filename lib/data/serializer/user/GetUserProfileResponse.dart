import 'dart:convert';

GetUserProfileResponse getUserProfileResponseFromJson(String str) =>
    GetUserProfileResponse.fromJson(json.decode(str));

String getUserProfileResponseToJson(GetUserProfileResponse data) =>
    json.encode(data.toJson());

class GetUserProfileResponse {
  GetUserProfileResponse({
    this.fullName,
    this.children,
    this.userAvatar,
    this.userName,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  GetUserProfileResponse.fromJson(dynamic json) {
    fullName = json['fullName'];

    userName = json['userName'];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
    userAvatar = json['userAvatar'] != null
        ? UserAvatar.fromJson(json['userAvatar'])
        : null;
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? fullName;
  String? userName;
  List<Children>? children;
  UserAvatar? userAvatar;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    if (userAvatar != null) {
      map['userAvatar'] = userAvatar?.toJson();
    }

     if (userName != null) {
      map['userName'] = userName;
    }
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

UserAvatar userAvatarFromJson(String str) =>
    UserAvatar.fromJson(json.decode(str));

String userAvatarToJson(UserAvatar data) => json.encode(data.toJson());

class UserAvatar {
  UserAvatar({
    this.users,
    this.content,
    this.mimeType,
    this.fileName,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  UserAvatar.fromJson(dynamic json) {
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
    content = json['content'];
    mimeType = json['mimeType'];
    fileName = json['fileName'];
    id = json['id'];
    statusCode = json['statusCode'];
  }

  List<Users>? users;
  String? content;
  String? mimeType;
  String? fileName;
  String? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    map['content'] = content;
    map['mimeType'] = mimeType;
    map['fileName'] = fileName;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
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
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  Users.fromJson(dynamic json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    isActive = json['isActive'];
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
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? fullName;
  String? email;
  String? password;
  dynamic confirmPassword;
  bool? isActive;
  String? activationCode;
  String? firstName;
  String? lastName;
  String? mobile;
  String? userName;
  dynamic token;
  dynamic newPassword;
  dynamic confirmNewPasswod;
  dynamic birtDay;
  String? avatarId;
  String? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['isActive'] = isActive;
    map['activationCode'] = activationCode;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['mobile'] = mobile;
    map['userName'] = userName;
    map['token'] = token;
    map['newPassword'] = newPassword;
    map['confirmNewPasswod'] = confirmNewPasswod;
    map['birtDay'] = birtDay;
    map['avatarId'] = avatarId;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Children childrenFromJson(String str) => Children.fromJson(json.decode(str));

String childrenToJson(Children data) => json.encode(data.toJson());

class Children {
  Children({
    this.fullName,
    this.age,
    this.birthDate,
    this.id,
    this.errorMessages,
    this.statusCode,
    this.successfulMessages,
  });

  Children.fromJson(dynamic json) {
    fullName = json['fullName'];
    age = json['age'];
    birthDate = json['birthDate'];
    id = json['id'];

    statusCode = json['statusCode'];
  }

  String? fullName;
  num? age;
  String? birthDate;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['age'] = age;
    map['birthDate'] = birthDate;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] =
          successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
