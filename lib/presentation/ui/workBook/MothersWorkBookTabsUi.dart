import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/MyTheme.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/child/GetChildsViewModel.dart';

class WorkBookTabBar extends StatelessWidget {
  const WorkBookTabBar({Key? key, required this.onSelectedItem})
      : super(key: key);
  final Function(ChildsItem) onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => GetChildViewModel(AppState.idle),
      builder: (bloc, state) {
        return Column(
          children: [
            ConditionalUI<List<ChildsItem>>(
              skeleton: Container(
                width: MediaQuery.of(context).size.width,
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
                  return Text(
                    'no_workbook'.tr,
                    style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: WidgetSize.smallTitle,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  );
                }
                return MothersWorkBookTabsUi(
                  items: data,
                  onSelectedItem: (cItem) {
                    onSelectedItem.call(cItem);
                    bloc.onChangeSelectedChild(cItem);
                  },
                );
              },
            ),
            4.dpv,
          ],
        );
      },
    );
  }
}

class MothersWorkBookTabsUi extends StatefulWidget {
  const MothersWorkBookTabsUi(
      {Key? key, required this.items, required this.onSelectedItem})
      : super(key: key);
  final List<ChildsItem> items;
  final Function(ChildsItem) onSelectedItem;

  @override
  State<MothersWorkBookTabsUi> createState() => _MothersWorkBookTabsUiState();
}

class _MothersWorkBookTabsUiState extends State<MothersWorkBookTabsUi>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var index = 0;

  @override
  void initState() {
    _tabController = TabController(length: widget.items.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        widget.onSelectedItem
            .call(widget.items.elementAt(_tabController.index));
        index = _tabController.index;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
        color: MyTheme.blue,
      ),
      child: Padding(
        padding: 16.dpe,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MamakTitle(title: 'workbook'.tr),
            16.dpv,
            Container(
              padding: 4.dpe,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: Colors.grey.withOpacity(.4),
              ),
              child: Align(
                alignment: Alignment.center,
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicator: BoxDecoration(
                      color: Colors.white, borderRadius: getBorderByZeroIndex()),
                  tabs: widget.items
                      .map(
                        (e) => WorkBookTabUi(name: e.childFirstName ?? ''),
                      )
                      .toList(),
                ),
              ),
            ),
            4.dpv,
          ],
        ),
      ),
    );
  }
}

class WorkBookTabUi extends StatelessWidget {
  const WorkBookTabUi({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Tab(
        child: Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

BorderRadius getBorderByZeroIndex() => const BorderRadius.all(Radius.circular(32.0));

BorderRadius getBorderByIndex(int index) {
  if (index == 0) {
    return const BorderRadius.only(
      topRight: Radius.circular(32.0),
      bottomRight: Radius.circular(32.0),
      topLeft: Radius.circular(4.0),
      bottomLeft: Radius.circular(4.0),
    );
  }
  if (index == 1) {
    return const BorderRadius.only(
      topLeft: Radius.circular(32.0),
      bottomLeft: Radius.circular(32.0),
      topRight: Radius.circular(4.0),
      bottomRight: Radius.circular(4.0),
    );
  }
  return BorderRadius.zero;
}
