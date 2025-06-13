import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';

class DropDownFormField extends StatelessWidget {
  const DropDownFormField({Key? key,
    required this.selectedItem,
    required this.items,
    required this.name,
    required this.onValueChange})
      : super(key: key);
  final DropDownModel? selectedItem;
  final List<DropDownModel> items;
  final String name;
  final Function(dynamic) onValueChange;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField(
        value: selectedItem?.data == 0 ? null : selectedItem?.data,
        menuMaxHeight: 200,
        isDense: false,
        isExpanded: false,
        borderRadius: const BorderRadius.all(
            Radius.circular(WidgetSize.textFieldRadiusSize)),
        hint: Text(
          name,
          style: context.textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: .9,
        ),
        onChanged: onValueChange,
        items: List.generate(items.length, (index) {
          var item = items.elementAt(index);
          return DropdownMenuItem(
            value: item.data,
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: .9,
            ),
          );
        }),
      ),
    );
  }
}

class DropDownModel<T> {

  T data;
  String name;

  DropDownModel({
    required this.data,
    required this.name
  });

}