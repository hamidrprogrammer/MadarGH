import 'package:badges/badges.dart' as badge;
import 'package:core/Notification/MyNotification.dart';
import 'package:core/utils/flow/MyFlow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/HomeNavigationModel.dart';
import 'package:my_ios_app/presentation/uiModel/bottomNavigation/model/MoreNavigationModel.dart';
import 'package:my_ios_app/presentation/viewModel/main/MainViewModel.dart';
import '../../../useCase/subscribe/GetRemainingDayUseCase.dart';

class RootNavigationUI extends StatefulWidget {
  const RootNavigationUI({
    Key? key,
    required this.menu,
    required this.onHomeIndexChange,
    required this.currentIndex,
    required this.isShownSecondMenu,
    required this.fake,
  }) : super(key: key);

  final List<HomeNavigationModel> menu;
  final Function(int) onHomeIndexChange;
  final int currentIndex;
  final bool isShownSecondMenu;
  final String fake;

  @override
  State<RootNavigationUI> createState() => _RootNavigationUIState();
}

class _RootNavigationUIState extends State<RootNavigationUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      elevation: .5,
      selectedLabelStyle: TextStyle(fontSize: 15,fontFamily: 'IRANSansXFaNum'),
       unselectedLabelStyle: TextStyle(fontSize: 13,fontFamily: 'IRANSansXFaNum'),
      backgroundColor: Colors.grey.shade50,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedItemColor: context.theme.primaryColor,
      items: widget.menu.asMap().entries.map(
        (entry) {
          final index = entry.key;
          final hbnI = entry.value;

          Color iconColor = index == absIndex
              ? Color(0xFFF15B67)
              : Color.fromARGB(255, 143, 143, 143);

          return BottomNavigationBarItem(
            icon: badge.Badge(
              badgeContent: hbnI.value() == HomeNavigationEnum.Subscription
                  ? FutureBuilder<String>(
                      future: GetRemainingDayUseCase().fetchRemainingDay(),
                      builder: (context, snapshot) {
                        String badgeText =
                            snapshot.hasData && snapshot.data!.isNotEmpty
                                ? snapshot.data!
                                : "";
                        return Text(badgeText,
                            style: const TextStyle(color: Colors.white));
                      },
                    )
                  : Text(hbnI.getBadge,
                      style: const TextStyle(color: Colors.white)),
              showBadge: hbnI.value() == HomeNavigationEnum.Subscription ||
                  (hbnI.getBadge.isNotEmpty),
              child: hbnI.getIcon(iconColor),
            ),
            label: hbnI.getName,

          );
        },
      ).toList(),
      currentIndex: index,
      onTap: (value) {
        widget.onHomeIndexChange.call(widget.menu[value].value().value);
      },
    );
  }

  int get absIndex {
    return widget.menu
        .indexWhere((element) => element.index == widget.currentIndex);
  }

  int get index {
    var index = absIndex;
    return index == -1 ? 0 : index;
  }
}

class MoreIconButton extends StatefulWidget {
  const MoreIconButton({Key? key, required this.isShownSecondMenu})
      : super(key: key);
  final bool isShownSecondMenu;

  @override
  State<MoreIconButton> createState() => _MoreIconButtonState();
}

class _MoreIconButtonState extends State<MoreIconButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<MainViewModel>().animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    context.read<MainViewModel>().animationController?.dispose();
    context.read<MainViewModel>().animationController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0)
          .animate(context.read<MainViewModel>().animationController!),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.5)),
        child: const Icon(
          CupertinoIcons.chevron_up,
          color: Colors.black,
        ),
      ),
    );
  }
}
