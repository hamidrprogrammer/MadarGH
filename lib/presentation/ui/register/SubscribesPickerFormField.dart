import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/BaseShimmer.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';

class ExamTimePickerFormField extends StatelessWidget {
  const ExamTimePickerFormField({
    super.key,
    required this.state,
    required this.onValueChange,
    required this.selectedItem,
  });

  final AppState state;
  final Function(int?) onValueChange;
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<List<SubscribeItem>>(
      skeleton: const TimesSkeleton(),
      state: state,
      onSuccess: (subscribes) {
        return ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<int>(
            value: selectedItem == 0 ? null : selectedItem,
            menuMaxHeight: 300,
            isDense: false,
            isExpanded: false,
            borderRadius: const BorderRadius.all(Radius.circular(WidgetSize.textFieldRadiusSize)),
            hint: Text(
              'subscribe'.tr,
              style: context.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onChanged: onValueChange,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.date_range),
            ),
            items: List.generate(subscribes.length, (index) {
              var item = subscribes.elementAt(index);
              return DropdownMenuItem<int>(
                value: item.id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: Text(
                          item.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class TimesSkeleton extends StatelessWidget {
  const TimesSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: const EdgeInsets.all(WidgetSize.basePaddingSize),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}
