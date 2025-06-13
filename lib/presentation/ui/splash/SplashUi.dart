import 'package:flutter/material.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/viewModel/user/SplashViewModel.dart';

class SplashUi extends StatelessWidget {
  const SplashUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => SplashViewModel(AppState.idle),
      builder: (bloc, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   gradient: RadialGradient(
          //     colors: [
          //       MyTheme.purple.withOpacity(.5),
          //       MyTheme.purple
          //     ],
          //     focalRadius: .5,
          //   ),
          // ),
          child: Image.asset('assets/splash.png', fit: BoxFit.fill),
        );
      },
    );
  }
}
