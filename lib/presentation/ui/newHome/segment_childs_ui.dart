import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final String iconAsset;
  final VoidCallback onPressed; // Add a callback for the button press

  MenuButton(
      {required this.text, required this.iconAsset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Define the tap action
      child: Column(
        children: [
          SvgPicture.asset(iconAsset, width: 56, height: 56),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.white,   fontFamily: 'IRANSansXFaNum',),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButtonTow extends StatelessWidget {
  final String text;
  final String iconAsset;

  MenuButtonTow({required this.text, required this.iconAsset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        iconAsset != null
            ? Image.network(
                iconAsset!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              )
            : SvgPicture.asset(
                'assets/group-60.svg',
                width: 56,
                height: 56,
              ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.white,   fontFamily: 'IRANSansXFaNum',),
          ),
        ),
      ],
    );
  }
}

class HorizontalScrollWithArrows extends StatefulWidget {
  @override
  final List<ChildsItem> childs;
  final Function(ChildsItem) onSelectChild;
  final AppState state;
  final AppState stateWork;

  final ChildsItem? selectedChild;
  final Function(String id) onSelectChildWork;

  HorizontalScrollWithArrows(
      {required this.childs,
      required this.onSelectChild,
      required this.onSelectChildWork,
      required this.stateWork,
      required this.state,
      this.selectedChild});
  _HorizontalScrollWithArrowsState createState() =>
      _HorizontalScrollWithArrowsState();
}

class _HorizontalScrollWithArrowsState
    extends State<HorizontalScrollWithArrows> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              50.dpv,
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left, color: Colors.white),
                    onPressed: _scrollLeft,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          widget.childs.length + 1,
                          (index) {
                            // If index is 0, maybe you want a different MenuButton or a placeholder
                            if (index != 0) {
                              if (widget.childs[index - 1]?.avatar != null) {
                                return MenuButtonTow(
                                  text:
                                      "${widget.childs[index - 1]?.childFirstName!} ${widget.childs[index - 1].childLastName}",
                                  iconAsset: widget.childs[index - 1].avatar
                                      .toString(),
                                );
                              } else {
                                return MenuButton(
                                  text:
                                      "${widget.childs[index - 1]?.childFirstName!} ${widget.childs[index - 1].childLastName}",
                                  iconAsset: './assets/group-60.svg',
                                  onPressed: () {
                                    print(widget.childs.first.childFirstName
                                        .toString());
                                    print("${widget.childs.first.id}");
                                    print("userChildId");
                                    widget.onSelectChildWork
                                        .call("${widget.childs.first.id}");
                                    // Define the action here
                                    widget.onSelectChild
                                        .call(widget.childs.first);
                                  },
                                );
                              }
                            } else {
                              return MenuButton(
                                text: 'فرزند جدید',
                                iconAsset: './assets/vectors/group_3_x2.svg',
                                onPressed: () {
                                  // Define the action here
                                  print('Home button pressed');
                                },
                              ); // Adjust if you need to use widget.childs[index - 1]
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right, color: Colors.white),
                    onPressed: _scrollRight,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class SegmentChildUi extends StatelessWidget {
  const SegmentChildUi(
      {Key? key,
      required this.onSelectChild,
      required this.onSelectChildWork,
      required this.stateWork,
      required this.state,
      this.selectedChild})
      : super(key: key);
  final Function(ChildsItem) onSelectChild;
  final Function(String id) onSelectChildWork;
  final AppState stateWork;
  final AppState state;
  final ChildsItem? selectedChild;

  @override
  Widget build(BuildContext context) {
    return ConditionalUI<List<ChildsItem>>(
        skeleton: const MyLoaderBig(),
        state: state,
        onSuccess: (childs) {
          return Scaffold(
            body: HorizontalScrollWithArrows(
              childs: childs,
              onSelectChild: onSelectChild,
              onSelectChildWork: onSelectChildWork,
              state: state,
              stateWork: stateWork,
              selectedChild: selectedChild,
            ),
          );
        });
  }
}
