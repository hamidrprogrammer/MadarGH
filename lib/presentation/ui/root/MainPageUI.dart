import 'package:flutter/material.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/root/RootNavigationUI.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/viewModel/main/MainViewModel.dart';

class MainPageUI extends StatefulWidget {
  const MainPageUI({Key? key}) : super(key: key);

  @override
  State<MainPageUI> createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI> {
  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => MainViewModel(AppState.idle),
      builder: (bloc, state) {
        print(bloc.showSecondMenu);
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              bloc.currentValue.toHomeNavigationEnum().getPage(),
              // if (bloc.showSecondMenu)
              AnimatedOpacity(
                opacity: bloc.showSecondMenu ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: IgnorePointer(
                  ignoring: bloc.showSecondMenu
                      ? false
                      : true, // Ignore pointer events when opacity is 0
                  child: RootNavigationUI(
                    isShownSecondMenu: false,
                    menu: [],
                    fake: "bloc.fake",
                    onHomeIndexChange: bloc.onIndexChange.call(),
                    currentIndex: bloc.currentValue,
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: RootNavigationUI(
            menu: bloc.homeMenu,
            fake: "",
            currentIndex: bloc.currentValue,
            onHomeIndexChange: bloc.onIndexChange.call(),
            isShownSecondMenu: bloc.showSecondMenu,
          ),
        );
      },
    );
  }
}
