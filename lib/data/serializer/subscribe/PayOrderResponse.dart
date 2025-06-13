import 'dart:convert';
PayOrderResponse payOrderResponseFromJson(String str) => PayOrderResponse.fromJson(json.decode(str));
String payOrderResponseToJson(PayOrderResponse data) => json.encode(data.toJson());
class PayOrderResponse {
  PayOrderResponse({
      this.item1, 
      this.item2,});

  PayOrderResponse.fromJson(dynamic json) {
    item1 = json['item1'];
    item2 = json['item2'];
  }
  num? item1;
  String? item2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item1'] = item1;
    map['item2'] = item2;
    return map;
  }

}