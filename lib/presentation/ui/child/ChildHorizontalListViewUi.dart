import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/child/GetChildsViewModel.dart';

class ChildHorizontalListViewUi extends StatelessWidget {
  const ChildHorizontalListViewUi(
      {Key? key, required this.onSelectedItem, required this.isAssessment})
      : super(key: key);
  final Function(ChildsItem) onSelectedItem;
  final bool isAssessment;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetChildViewModel(AppState.idle),
      builder: (bloc, state) {
        return Column(
          children: [
            SizedBox(
              height: 55,
              child: ConditionalUI<List<ChildsItem>>(
                skeleton: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  margin: 8.dpe,
                  padding: 8.dpe,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: 8.bRadius,
                  ),
                ),
                state: bloc.uiState,
                onSuccess: (data) {
                  if (data.isEmpty) {
                    if (isAssessment) {
                      return TextButton(
                          onPressed: bloc.goToAddChild,
                          child: Text('click_to_add_child'.tr));
                    } else {
                      return Text(
                        'no_workbook'.tr,
                        style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: WidgetSize.smallTitle,
                            color: Colors.white,
                            fontFamily: 'IRANSansXFaNum',
                        ),
                        textAlign: TextAlign.start,
                      );
                    }
                  }
                  return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0),side: const BorderSide(color: Colors.grey, width: 1)),color: Colors.white,
                    child: Align(
                      alignment: Alignment.center,
                      child: ListView.separated(
                      shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: 8.dpe,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //TODO add auto emit first id
                              bloc.onChangeSelectedChild(data[index]);
                              onSelectedItem.call(data[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              child: Text(
                                '${data[index].childFirstName} ${data[index]
                                    .childLastName}',
                                style: TextStyle(
                                     fontFamily: 'IRANSansXFaNum',
                                  fontWeight: bloc.selectedChild ==
                                      data[index]
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: bloc.selectedChild == data[index]
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const VerticalDivider(
                            width: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: data.length,
                      ),
                    ),
                  );
                },
              ),
            ),
            4.dpv,
            const Text(''),
            4.dpv,
          ],
        );
      },
    );
  }
}
