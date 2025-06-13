import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/home/slider/slider_content_response.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/viewModel/app/home_slider_vm.dart';

class HomeSliderUi extends StatefulWidget {
  const HomeSliderUi({Key? key}) : super(key: key);

  @override
  State<HomeSliderUi> createState() => _HomeSliderUiState();
}

class _HomeSliderUiState extends State<HomeSliderUi> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeSliderViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<SliderContentResponse>(
          skeleton: Container(
            height: 300,
            width: Get.width,
            color: Colors.grey.shade200,
          ),
          state: state,
          onSuccess: (slider) {
            return PageView(
              physics: const BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: (slider.images?.map((e) => e.content).toList() ?? [])
                  .map(
                    (image) => SizedBox(
                      height: 270.0,
                      child: Image.memory(
                        base64Decode(image ?? ''),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}
