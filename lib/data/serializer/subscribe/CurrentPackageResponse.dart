import 'dart:convert';
CurrentPackageResponse currentPackageResponseFromJson(String str) => CurrentPackageResponse.fromJson(json.decode(str));
String currentPackageResponseToJson(CurrentPackageResponse data) => json.encode(data.toJson());
class CurrentPackageResponse {
  CurrentPackageResponse({
      this.title, 
      this.persianEndDate, 
      this.id,});

  CurrentPackageResponse.fromJson(dynamic json) {
    title = json['title'];
    persianEndDate = json['persianEndDate'];
    id = json['id'];
  }
  String? title;
  String? persianEndDate;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['persianEndDate'] = persianEndDate;
    map['id'] = id;
    return map;
  }

}