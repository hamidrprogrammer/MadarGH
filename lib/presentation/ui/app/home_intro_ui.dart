import 'package:core/videoPlayer/MyVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/home/intro/intro_content_response.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/viewModel/app/home_intro_vm.dart';

class HomeIntroUi extends StatelessWidget {
  const HomeIntroUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => HomeIntroViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<IntroContentResponse>(
          skeleton: Container(
            height: 300,
            width: Get.width,
            color: Colors.grey.shade200,
          ),
          state: state,
          onSuccess: (video) {
            return MyVideoPlayer(
              data: video.video?.content ?? '',
            );
          },
        );
      },
    );
  }
}
