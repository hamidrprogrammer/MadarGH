import 'dart:convert';

List<CityItem> cityItemsFromJson(String str) => List<CityItem>.from(
    json.decode(str).map((x) => CityItem.fromJson(x)));

class CityItem {
  CityItem({
    this.cityCode,
    this.cityName,
    this.id,
  });

  CityItem.fromJson(dynamic json) {
    cityCode = json['cityCode'];
    cityName = json['cityName'];
    id = json['id'];
  }

  String? cityCode;
  String? cityName;
  num? id;
}
