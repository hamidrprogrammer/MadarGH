import 'dart:convert';
ContactUsResponse contactUsResponseFromJson(String str) => ContactUsResponse.fromJson(json.decode(str));
String contactUsResponseToJson(ContactUsResponse data) => json.encode(data.toJson());
class ContactUsResponse {
  ContactUsResponse({
      this.email, 
      this.fullName, 
      this.tellNumber,
      this.subject, 
      this.address,
      this.latitude, 
      this.longitude, 
      this.id, 
      this.errorMessages, 
      this.statusCode, 
      this.successfulMessages,});

  ContactUsResponse.fromJson(dynamic json) {
    email = json['email'];
    fullName = json['fullName'];
    tellNumber = json['tellNumber'];
    subject = json['subject'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];

    statusCode = json['statusCode'];
  }
  String? email;
  String? fullName;
  String? tellNumber;
  String? subject;
  String? address;
  num? latitude;
  num? longitude;
  num? id;
  List<dynamic>? errorMessages;
  num? statusCode;
  List<dynamic>? successfulMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['fullName'] = fullName;
    map['tellNumber'] = tellNumber;
    map['subject'] = subject;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['id'] = id;
    if (errorMessages != null) {
      map['errorMessages'] = errorMessages?.map((v) => v.toJson()).toList();
    }
    map['statusCode'] = statusCode;
    if (successfulMessages != null) {
      map['successfulMessages'] = successfulMessages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}