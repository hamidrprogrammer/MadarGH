import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/app/about_us_vm.dart';

class IntroductionUI extends StatelessWidget {
  const IntroductionUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (_) => AboutUsViewModel(AppState.idle),
      builder: (bloc, state) {
        return MamakScaffold(
          body: SingleChildScrollView(
            child: ConditionalUI<dynamic>(
              skeleton: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: MyLoader()),
              ),
              state: state,
              onSuccess: (data) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      8.dpv,
                      Text(
                        'intruduce_mamak'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      8.dpv,
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: ResizeImage(
                              MemoryImage(base64Decode(data)),
                              width: MediaQuery.of(context).size.width.toInt(),
                            ))),
                      ),
                    ]);
              },
            ),
          ),
        );
      },
    );
  }
}
