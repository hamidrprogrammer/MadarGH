import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'InformationBodey.g.dart';
InformationBody getUserInformationBodyFromJson(String str) =>
    InformationBody.fromJson(json.decode(str));
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InformationBody {
  final String? firstName;
  final String? lastName;
  final int? motherEducation;
  final String? motherJobTitle;
  final int? motherJobStatus;
  final int? fatherEducation;
  final String? fatherJobTitle;
  final int? fatherJobStatus;
  final int? maritalStatus;
  final int? mentalPeace;
  final int? support;
  final int? health;
  final String? id;

  InformationBody({
    required this.firstName,
    required this.lastName,
    required this.motherEducation,
    required this.motherJobTitle,
    required this.motherJobStatus,
    required this.fatherEducation,
    required this.fatherJobTitle,
    required this.fatherJobStatus,
    required this.maritalStatus,
    required this.mentalPeace,
    required this.support,
    required this.health,
    required this.id,
  });

  factory InformationBody.fromJson(Map<String, dynamic> json) {
    return InformationBody(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
      motherEducation: json['motherEducation'],
      motherJobTitle: json['motherJobTitle'],
      motherJobStatus: json['motherJobStatus'],
      fatherEducation: json['fatherEducation'],
      fatherJobTitle: json['fatherJobTitle'],
      fatherJobStatus: json['fatherJobStatus'],
      maritalStatus: json['maritalStatus'],
      mentalPeace: json['mentalPeace'],
      support: json['support'],
      health: json['health'],
    );
  }
  Map<String, dynamic> toJson() => _$InformationBodyToJson(this);

// "isSuccess": true,
// "statusMessage": "string",
}

class UserInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String persianRegisterDate;
  final bool isActive;
  final List<Role> roles;
  final List<Subscription> subscriptions;
  final List<Child> children;
  final List<Order> orders;
  final ActiveSubscription activeSubscription;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.persianRegisterDate,
    required this.isActive,
    required this.roles,
    required this.subscriptions,
    required this.children,
    required this.orders,
    required this.activeSubscription,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserInfo(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      persianRegisterDate: json['persianRegisterDate'] ?? '',
      isActive: json['isActive'] ?? false,
      roles: (json['roles'] as List).map((e) => Role.fromJson(e)).toList(),
      subscriptions: (json['subscriptions'] as List)
          .map((e) => Subscription.fromJson(e))
          .toList(),
      children:
          (json['children'] as List).map((e) => Child.fromJson(e)).toList(),
      orders: (json['orders'] as List).map((e) => Order.fromJson(e)).toList(),
      activeSubscription:
          ActiveSubscription.fromJson(json['activeSubscription']),
    );
  }
}

class Role {
  final int roleId;
  final String roleName;

  Role({
    required this.roleId,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['roleId'] ?? 0,
      roleName: json['roleName'] ?? '',
    );
  }
}

class Subscription {
  final String subsciptionTitle;
  final String startPersianDate;
  final String endPersianDate;

  Subscription({
    required this.subsciptionTitle,
    required this.startPersianDate,
    required this.endPersianDate,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      subsciptionTitle: json['subsciptionTitle'] ?? '',
      startPersianDate: json['startPersianDate'] ?? '',
      endPersianDate: json['endPersianDate'] ?? '',
    );
  }
}

class Child {
  final String childFirstName;
  final String childLastName;
  final String persianBirthDate;
  final int childAge;

  Child({
    required this.childFirstName,
    required this.childLastName,
    required this.persianBirthDate,
    required this.childAge,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childFirstName: json['childFirstName'] ?? '',
      childLastName: json['childLastName'] ?? '',
      persianBirthDate: json['persianBirthDate'] ?? '',
      childAge: json['childAge'] ?? 0,
    );
  }
}

class Order {
  final String orderNumber;
  final bool isPay;
  final int totalPriceWithDiscount;
  final String discountCode;
  final String paymentPersianDate;

  Order({
    required this.orderNumber,
    required this.isPay,
    required this.totalPriceWithDiscount,
    required this.discountCode,
    required this.paymentPersianDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'] ?? '',
      isPay: json['isPay'] ?? false,
      totalPriceWithDiscount: json['totalPriceWithDiscount'] ?? 0,
      discountCode: json['discountCode'] ?? '',
      paymentPersianDate: json['paymentPersianDate'] ?? '',
    );
  }
}

class ActiveSubscription {
  final String subscriptionTitle;
  final String startPersianDate;
  final String endPersianDate;

  ActiveSubscription({
    required this.subscriptionTitle,
    required this.startPersianDate,
    required this.endPersianDate,
  });

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) {
    return ActiveSubscription(
      subscriptionTitle: json['subscriptionTitle'] ?? '',
      startPersianDate: json['startPersianDate'] ?? '',
      endPersianDate: json['endPersianDate'] ?? '',
    );
  }
}
