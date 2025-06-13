import 'dart:convert';

List<ProvinceItem> provinceItemsFromJson(String str) => List<ProvinceItem>.from(
    json.decode(str).map((x) => ProvinceItem.fromJson(x)));

class ProvinceItem {
  ProvinceItem({
    this.provinceCode,
    this.provinceName,
    this.id,
  });

  ProvinceItem.fromJson(dynamic json) {
    provinceCode = json['provinceCode'];
    provinceName = json['provinceName'];
    id = json['id'];
  }

  String? provinceCode;
  String? provinceName;
  num? id;
}
