// To parse this JSON data, do
//
//     final allSubscriptionItem = allSubscriptionItemFromJson(jsonString);

import 'dart:convert';

List<AllSubscriptionItem> allSubscriptionItemFromJson(String str) =>
    List<AllSubscriptionItem>.from(
        json.decode(str).map((x) => AllSubscriptionItem.fromJson(x)));

String allSubscriptionItemToJson(List<AllSubscriptionItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSubscriptionItem {
  int? id;
  String? title;
  int? price, discount;
  int? durationDay;
  String? cafeBazaarIdentity;

  AllSubscriptionItem(
      {this.id,
      this.title,
      this.price,
      this.durationDay,
      this.cafeBazaarIdentity});

  factory AllSubscriptionItem.fromJson(Map<String, dynamic> json) =>
      AllSubscriptionItem(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        durationDay: json["durationDay"],
        cafeBazaarIdentity: json["cafeBazaarIdentity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "durationDay": durationDay,
        "cafeBazaarIdentity": cafeBazaarIdentity,
      };
}
