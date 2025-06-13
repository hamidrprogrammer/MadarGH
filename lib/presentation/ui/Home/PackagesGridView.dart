import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/child/GetAllUserChilPackageResponse.dart';
import 'package:my_ios_app/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';

class PackagesGridView extends StatelessWidget {
  const PackagesGridView(
      {Key? key, required this.packages, required this.childPackage})
      : super(key: key);
  final List<SubscribeItem?> packages;
  final List<ChildPackage> childPackage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: packages.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          mainAxisExtent: (MediaQuery.of(context).size.width / 3) + 30),
      itemBuilder: (context, index) => PackagesItemUI(
        package: packages[index],
        childPackage: childPackage.getChildPackage(
          packages[index]?.id?.toString(),
        ),
      ),
    );
  }
}

class PackagesItemUI extends StatelessWidget {
  const PackagesItemUI({
    Key? key,
    required this.package,
    required this.childPackage,
  }) : super(key: key);
  final SubscribeItem? package;
  final ChildPackage? childPackage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GetIt.I.get<NavigationServiceImpl>().navigateTo(
              AppRoute.packageDetail,
              package?.id?.toString(),
            );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(color: Colors.grey)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0)),
              child: SizedBox(
                child: Image.memory(
                  base64Decode(
                      package?.parentCategoryFiles?.first.file?.content ?? ''),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(),
            AutoSizeText(
              package?.title ?? '',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: WidgetSize.autoTitle,
              ),
              textScaleFactor: 1.0,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Text(package?.description ?? ''),
            // ),
            if (childPackage != null)
              Row(
                children: [
                  Container(
                    margin: 2.dpe,
                    alignment: Alignment.center,
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black)),
                    child: (childPackage != null &&
                            childPackage?.childPicture != null)
                        ? ClipRRect(
                            borderRadius: 45.bRadius,
                            child: Image.memory(
                              base64Decode(
                                  childPackage!.childPicture!.content!),
                              fit: BoxFit.fill,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 12,
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: AutoSizeText(
                        childPackage?.childName ?? '',
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
            const Spacer()
          ],
        ),
      ),
    );
  }
}
