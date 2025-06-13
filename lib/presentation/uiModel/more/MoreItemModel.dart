import 'package:flutter/cupertino.dart';

class MoreItemModel {
  final IconData iconData;
  final String name;
  final Function() onClick;

  const MoreItemModel({required this.iconData, required this.name, required this.onClick});
}
