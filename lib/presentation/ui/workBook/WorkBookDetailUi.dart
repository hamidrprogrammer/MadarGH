import 'package:core/chart.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/config/uiCommon/MyTheme.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MamakTitle.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/newHome/new_home_ui.dart';
import 'package:my_ios_app/presentation/ui/workBook/TotalWorkBookChartUi.dart';
import 'package:my_ios_app/presentation/ui/workBook/WorkBookTableUi.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:my_ios_app/presentation/viewModel/home/new_home_viewModel.dart';
import 'package:my_ios_app/presentation/viewModel/workBook/ReportCardViewModel.dart';

import '../../../data/serializer/workBook/WorkBookDetailResponse.dart';
import 'AccordionDemo.dart';

class WorkBookDetailUi extends StatelessWidget {
  const WorkBookDetailUi({Key? key}) : super(key: key);

  Widget _buildContentBox(
      WorkBookDetailReviews item, int index, Function() onItemClick) {
    final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

    return CubitProvider(
      create: (context) =>
          AccordionViewModel(AppState.idle, item.id.toString()),
      builder: (bloc, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      // Wrap with Expanded
                      child: Text(
                        '$index. ${item.question}',
                        style: TextStyle(
                          fontFamily: 'IRANSansXFaNum',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF505463),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/ellipse-52.svg',
                      width: 4,
                      height: 4,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'mother_comment'.tr,
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Color(0xFF9E3840),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      // Wrap with Expanded
                      child: Text(
                        item.comment,
                        style: TextStyle(
                          fontFamily: 'IRANSansXFaNum',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFF505463),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xFFD3D6DE),
                  height: 20,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/ellipse-52.svg',
                      width: 4,
                      height: 4,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'strategies'.tr,
                      style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Color(0xFF9E3840),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                CubitProvider(
                  create: (context) =>
                      AccordionViewModel(AppState.idle, item.id.toString()),
                  builder: (bloc, state) {
                    return ConditionalUI<List<Accordion>>(
                      showError: false,
                      state: state,
                      onSuccess: (data) {
                        print('Data: ${data.toString()}'); // Debugging line
                        return SizedBox(
                          height: data.length *
                              40, // Specify height or wrap in Expanded/Flexible
                          child: ListView.builder(
                            physics:
                                NeverScrollableScrollPhysics(), // Disable scrolling

                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Your tap functionality here
                                  Get.toNamed(
                                    AppRoute.workDetails,
                                    arguments: data[index],
                                  );
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${data[index].title}',
                                          style: TextStyle(
                                            fontFamily: 'IRANSansXFaNum',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Color(0xFF505463),
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                        'assets/huge-icon-arrows-outline-maximize-01-7.svg',
                                        width: 18,
                                        height: 18,
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => ReportCardViewModel(AppState.idle),
      builder: (bloc, state) {
        return ConditionalUI<WorkBookDetailUiModel>(
          showError: false,
          state: bloc.reportCardTopicZState,
          onSuccess: (data) {
            print("WorkBookDetailUiModel");
            print("${data.workShopWorkBookTitle}");
            var childData = data;
            return Scaffold(
                backgroundColor: const Color(0xFFF8F8FC),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: kIsWeb ? 0 : 15,
                        child: Image.asset(
                          'assets/Rectangle21.png', // Path to your SVG file
                          fit: BoxFit.fitWidth,
                          // To cover the entire AppBar
                        ),
                      ),
                      AppBar(
                        title: Text(
                          data.workShopWorkBookTitle,
                          style: TextStyle(
                            fontFamily: 'IRANSansXFaNum',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        iconTheme: IconThemeData(color: Colors.white),

                        backgroundColor: Color.fromARGB(
                            0, 255, 252, 252), // Make AppBar transparent
                        elevation: 0, // Remove shadow
                      ),
                    ],
                  ),
                ),
                body: FutureBuilder(
                    future: bloc.getChildItem(),
                    builder: (context, snapshot) {
                      ChildsItem? selectedChild;
                      if (snapshot.hasData && snapshot.data is ChildsItem) {
                        selectedChild = snapshot.data as ChildsItem;
                        print("nullllllllll");
                      } else {
                        print("nullllllllll");
                      }

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                width: 351,
                                height: 48,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/rectangle-29.svg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${selectedChild?.childFirstName} ${selectedChild?.childLastName}',
                                          style: TextStyle(
                                            fontFamily: 'IRANSansXFaNum',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Color(0xFF696F82),
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        Text(
                                          '${selectedChild?.childAge == null ? "" : selectedChild?.childAge}',
                                          style: TextStyle(
                                            fontFamily: 'IRANSansXFaNum',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            color: Color(0xFF696F82),
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                    // SvgPicture.asset('assets/group-48097768.svg'),
                                    // SvgPicture.asset('assets/group-60.svg'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                             ConditionalUI<WorkBookDetailUiModel>(
                                      showError: false,
                                      skeleton: Center(
                                        child: MyLoaderBig(),
                                      ),
                                      state: bloc.reportCardState,
                                      onSuccess: (reportCard) {
                                        var data = bloc.getTotalChartData(
                                            reportCard.cards,
                                            reportCard.categories);
                                        return Container(
                                          height: 410,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(children: [
                                            Positioned(
                                                child: Center(
                                              child: Column(children: [
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      child: GroupWidget(
                                                        assetName:
                                                            'assets/group-22-4.svg',
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                    246, 95, 92)
                                                                .withOpacity(
                                                                    0.3),
                                                        text: 'mathematics'
                                                            .tr, // Use 'mathematics'.tr if using localization
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                    height:
                                                        8), // Space between rows
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GroupWidget(
                                                      assetName:
                                                          'assets/group-22-2.svg',
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                                  248, 246, 133)
                                                              .withOpacity(
                                                                  0.3),
                                                      text: 'workshop_description'
                                                          .tr, // Use 'workshop_description'.tr if using localization
                                                    ),
                                                    GroupWidget(
                                                      assetName:
                                                          'assets/group-22.svg',
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                                  84, 163, 197)
                                                              .withOpacity(
                                                                  0.3),
                                                    text: 'reading_literacy'
                                                                        .tr,// Use 'life_skills'.tr if using localization
                                                    ),
                                                  ],
                                                ),
                                                // Row for bottom items
                                                SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GroupWidget(
                                                      assetName:
                                                          'assets/group-22-3.svg',
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                                  220, 132, 191)
                                                              .withOpacity(
                                                                  0.3),
                                                      text: 'art'
                                                          .tr, // Use 'art'.tr if using localization
                                                    ),
                                                    GroupWidget(
                                                      assetName:
                                                          'assets/group-22-5.svg',
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                                  253, 154, 149)
                                                              .withOpacity(
                                                                  0.3),
                                                       text: 'life_skills'
                                                          .tr,  // Use 'reading_literacy'.tr if using localization
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                    height:
                                                        20), // Space between legend and previous rows

                                                // Legend widgets
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    LegendWidget(
                                                      color: Color(0xFF3D9C68),
                                                      text: 'first_assessment'
                                                          .tr, // Use 'first_assessment'.tr if using localization
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            20), // Space between legends
                                                    LegendWidget(
                                                      color: Color(0xFFF15B67),
                                                      text: 'second_assessment'
                                                          .tr, // Use 'second_assessment'.tr if using localization
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            )),
                                            Center(
                                              child: Column(
                                                children: [
                                                  60.dpv,
                                                  RadarChart(
                                                    spaceCount: data.maxValue <
                                                            5
                                                        ? data.maxValue
                                                        : data.maxValue ~/ 5,
                                                    textScaleFactor: .03,
                                                    strokeColor: Colors.grey,
                                                    labelWidth: 0,
                                                    labelColor: Color.fromARGB(
                                                        0, 255, 255, 255),
                                                    values: [
                                                      ChartModel(
                                                        values:
                                                            data.values.first,
                                                        color: Color.fromARGB(
                                                            255, 0, 154, 18),
                                                      ),
                                                      ChartModel(
                                                        values:
                                                            data.values.last,
                                                        color: Color.fromARGB(
                                                            255, 255, 60, 0),
                                                      ),
                                                    ],
                                                    labels: data.name,
                                                    maxValue: data.maxValue
                                                        .toDouble(),
                                                    fillColor: Color.fromARGB(
                                                        255, 37, 169, 0),
                                                    maxLinesForLabels: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 10),
                                                SvgPicture.asset(
                                                  'assets/vectors/ellipse_504_x2.svg',
                                                  width: 5,
                                                  height: 5,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'Graphical_report_card'.tr,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'IRANSansXFaNum',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Color(0xFF272930),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ]),
                                        );
                                      },
                                    ),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  SvgPicture.asset(
                                    'assets/vectors/ellipse_504_x2.svg',
                                    width: 5,
                                    height: 5,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${'Graphical_report_card'.tr} ${childData.workShop}",
                                    style: const TextStyle(
                                      fontFamily: 'IRANSansXFaNum',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xFF272930),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              RadarChart(
                                spaceCount: 10,
                                textScaleFactor: 1,
                                strokeColor: Colors.grey,
                                values: [
                                  if (childData.workShpChartModel.values.first
                                      .isNotEmpty)
                                    ChartModel(
                                      values: childData
                                          .workShpChartModel.values.first,
                                      color: Colors.blue,
                                    ),
                                  if (childData
                                          .workShpChartModel.values.length >
                                      1)
                                    ChartModel(
                                      values: childData
                                          .workShpChartModel.values.last,
                                      color: Colors.green,
                                    ),
                                ],
                                labels: childData.workShpChartModel.name,
                                maxValue: childData.workShpChartModel.maxValue
                                    .toDouble(),
                                fillColor: Colors.blue,
                                maxLinesForLabels: 1,
                                maxWidth:
                                    MediaQuery.of(context).size.width - 120,
                                maxHeight:
                                    300,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'increasing_child_skills'.tr,
                                style: const TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF272930),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'suggest_play_duration'.tr,
                                style: const TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF505463),
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                itemBuilder: (context, index) =>
                                    _buildContentBox(
                                  data.reviews.elementAt(
                                      index), // First argument should be a WorkBookDetailReviews item
                                  index +
                                      1, // Second argument should be an int index
                                  () {
                                    bloc.onSolutionItemClick(
                                        data.reviews.elementAt(index));
                                  },
                                ),
                                shrinkWrap: true,
                                itemCount: data.reviews.length,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
          },
        );
      },
    );
  }
}

class WorkBookItemUi extends StatelessWidget {
  const WorkBookItemUi({Key? key, required this.data}) : super(key: key);
  final List<WorkBookModel> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.dpe,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: data.map((e) => WorkBookItemContentUi(model: e)).toList(),
          ),
          const SizedBox()
        ],
      ),
    );
  }
}

class WorkBookItemContentUi extends StatelessWidget {
  final WorkBookModel model;

  const WorkBookItemContentUi({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 4.dpev,
      child: Column(
        children: [
          Row(
            children: [
              MamakTitle(
                title: '${model.name}'.tr,
                fontSize: 15,
              ),
              4.dph,
              Container(
                margin: 4.dpeh,
                height: 20,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: model.color,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class WorkBookModel {
  final String name;
  final Color color;

  const WorkBookModel({required this.name, required this.color});
}

class SuggestionItemUi extends StatelessWidget {
  const SuggestionItemUi(
      {Key? key,
      required this.item,
      required this.index,
      required this.onItemClick})
      : super(key: key);
  final WorkBookDetailReviews item;
  final int index;
  final Function() onItemClick;

  @override
  Widget build(BuildContext context) {
    // Generate sample items

    return CubitProvider(
        create: (context) =>
            AccordionViewModel(AppState.idle, item.id.toString()),
        builder: (bloc, state) {
          return ConditionalUI<List<Accordion>>(
              state: state,
              showError: false,
              onSuccess: (data) {
                return Container(
                  padding: 16.dpe,
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: 16.radius,
                        bottomLeft: 16.radius,
                        bottomRight: 16.radius,
                      ),
                      color: Colors.grey.shade50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ability'.tr,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      8.dpv,
                      Text('$index.${item.question}',
                          style: context.textTheme.bodySmall),
                      8.dpv,
                      Container(
                        padding: 16.dpe,
                        margin: 8.dpe,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade200, width: 1),
                            borderRadius: BorderRadius.only(
                              topLeft: 16.radius,
                              bottomLeft: 16.radius,
                              bottomRight: 16.radius,
                            ),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'mothers_comment'.tr,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            8.dpv,
                            Text(item.comment,
                                style: context.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      8.dpv,
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.purple),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                    child: Container(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.8, // Set height to fill the screen
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.95, // Adjust the width as needed

                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        child: CubitProvider(
                                            create: (context) =>
                                                AccordionViewModel(
                                                    AppState.idle,
                                                    item.id.toString()),
                                            builder: (bloc, state) {
                                              return ConditionalUI<
                                                      List<Accordion>>(
                                                  state: state,
                                                  showError: false,
                                                  onSuccess: (data) {
                                                    return CustomDialog(
                                                      child: Center(
                                                        child: AccordionView(
                                                          items: generateItems(
                                                              data),
                                                          onExpansionChanged: (int
                                                                  index,
                                                              bool isExpanded) {
                                                            bloc.getChange(
                                                                index, data);
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            })));
                              },
                            );
                          },
                          icon: const Icon(Icons.list_alt_sharp),
                          label: Text(
                            'download_suggestion'.tr,
                          )),
                    ],
                  ),
                );
              });
        });
  }

  List<AccordionItem> generateItems(List<Accordion> sata) {
    return List<AccordionItem>.generate(sata.length, (int index) {
      return AccordionItem(
          headerValue: sata[index].title,
          expandedValue: sata[index].workMethod,
          isExpanded: sata[index].isExpanded,
          requiredTools: sata[index].requiredTools,
          learningOpportunity: sata[index].learningOpportunity);
    });
  }
}

class CustomDialog extends StatelessWidget {
  final Widget child;

  const CustomDialog({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      // Set background color to transparent
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'راهکارها',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
