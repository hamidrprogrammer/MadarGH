import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/home/CategoryResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/home/CategoriesViewModel.dart';

class CategoriesHorizontalListUi extends StatefulWidget {
  const CategoriesHorizontalListUi({Key? key}) : super(key: key);

  @override
  State<CategoriesHorizontalListUi> createState() =>
      _CategoriesHorizontalListUiState();
}

class _CategoriesHorizontalListUiState
    extends State<CategoriesHorizontalListUi> {
  late ScrollController controller;
  bool scrolled = false;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 5;
    return CubitProvider(
      create: (context) => CategoriesViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<List<Category>>(
          skeleton: Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            margin: 8.dpe,
            padding: 8.dpe,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: 8.bRadius,
            ),
          ),
          state: state,
          onSuccess: (data) {
            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                ListView.builder(
                  controller: controller,
                  padding: 8.dpe,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length) return const SizedBox(width: 60);
                    return InkWell(
                      onTap: () {
                        bloc.gotoDetail(data.elementAt(index).id?.toString());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width,
                              child: Image.memory(
                                base64Decode(data[index]
                                        .parentCategoryFiles
                                        ?.first
                                        .file
                                        ?.content ??
                                    ''),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AutoSizeText(
                                  data[index].title ?? '',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: WidgetSize.autoTitle,
                                  ),
                                  textScaleFactor: 1.0,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.animateTo(
                            scrolled
                                ? controller.position.minScrollExtent
                                : controller.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                          scrolled = !scrolled;
                          setState(() {});
                        },
                        child: Opacity(
                          opacity: .4,
                          child: Icon(
                              scrolled
                                  ? CupertinoIcons.left_chevron
                                  : CupertinoIcons.right_chevron,
                              size: 30),
                        )),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
