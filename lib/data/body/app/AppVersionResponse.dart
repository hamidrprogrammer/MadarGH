import 'dart:convert';
AppVersionResponse appVersionResponseFromJson(String str) => AppVersionResponse.fromJson(json.decode(str));
String appVersionResponseToJson(AppVersionResponse data) => json.encode(data.toJson());
class AppVersionResponse {
  AppVersionResponse({
      this.versionNumber, 
      this.releaseDateTime, 
      this.linkUrl,});

  AppVersionResponse.fromJson(dynamic json) {
    versionNumber = json['versionNumber'];
    releaseDateTime = json['releaseDateTime'];
    linkUrl = json['linkUrl'];
  }
  String? versionNumber;
  String? releaseDateTime;
  String? linkUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['versionNumber'] = versionNumber;
    map['releaseDateTime'] = releaseDateTime;
    map['linkUrl'] = linkUrl;
    return map;
  }

}