import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/child/EditChilViewModel.dart';
import 'package:my_ios_app/presentation/viewModel/user/ProfileViewModel.dart';

class ChildsProfileUi extends StatefulWidget {
  const ChildsProfileUi({Key? key, required this.children}) : super(key: key);
  final List<ChildsItem> children;

  @override
  State<ChildsProfileUi> createState() => _ChildsProfileUiState();
}

class _ChildsProfileUiState extends State<ChildsProfileUi>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late EditChildDataViewModel viewModel;
  var index = 0;

  @override
  void initState() {
    viewModel = EditChildDataViewModel(AppState.idle);
    if (viewModel.selectedChild == null && widget.children.isNotEmpty) {
      viewModel.changeSelectedChild(widget.children.first);
    }
    _tabController = TabController(length: widget.children.length, vsync: this);
    _tabController.addListener(() {
      viewModel.changeSelectedChild(widget.children[_tabController.index]);
      setState(() {
        index = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var year = 'year'.tr;
    // Logger.d(msg)
    return CubitProvider(
      create: (context) => viewModel,
      builder: (bloc, state) {
        return Column(
          children: [
            TabBar(
              isScrollable: true,
              indicator: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0),
                  )),
              controller: _tabController,
              tabs: List.generate(
                widget.children.length,
                (index) => SizedBox(
                  height: 40,
                  child: Tab(
                    child: Text(
                      '${widget.children[index].childFirstName} ${widget.children[index].childLastName}',
                      style: const TextStyle(fontSize: 12,   fontFamily: 'IRANSansXFaNum',),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.children.isNotEmpty)
              Container(
                padding: 16.dpe,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            right: 10,
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: bloc.selectedImage != null &&
                                            bloc.selectedImage?.content !=
                                                null &&
                                            bloc.selectedImage?.content != ''
                                        ? ClipRRect(
                                            borderRadius: 45.bRadius,
                                            child: Image.memory(
                                              bloc.selectedImage!
                                                  .getFileFormBase64(),
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                  ),
                                )),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: ()=>{
                                
                                bloc.pickImage(widget.children[index])},
                              borderRadius: 30.bRadius,
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 30,
                                padding: 4.dpe,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey)),
                                child: bloc.uploadState.isLoading
                                    ? const MyLoader(radius: 7.0)
                                    : const Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    8.dph,
                    Row(
                      children: [
                        Directionality(textDirection: TextDirection.rtl,child: Text(' ${widget.children[index].childAge?.toString()} ')),

                      ],
                    )
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
