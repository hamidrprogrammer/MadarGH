import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      child: Padding(
        padding: 8.dpeh,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getContent,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data is String &&
                    snapshot.data != '') {
                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: 45.bRadius,
                      child: Image.memory(
                        base64Decode(snapshot.data!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
                return const Icon(CupertinoIcons.person_alt_circle);
              },
            ),
            8.dph,
            Row(
              children: [
                FutureBuilder(
                  future: getUserFullName,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data?.toString() ?? ''
                          : 'user_name'.tr,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> get getUserFullName async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.fullName);

  Future<String> get getContent async =>
      GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.image);
}
