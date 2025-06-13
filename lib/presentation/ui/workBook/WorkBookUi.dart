import 'dart:convert';
import 'dart:typed_data';
import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/radar_chart.dart';
import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';
import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBooksResponse.dart';
import 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/ConditionalUI.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/MamakScaffold.dart';
import 'package:my_ios_app/presentation/ui/main/MyLoader.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/ui/newHome/new_home_ui.dart';
import 'package:my_ios_app/presentation/ui/workBook/MothersWorkBookTabsUi.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookDetailUiModel.dart';
import 'package:my_ios_app/presentation/viewModel/home/new_home_viewModel.dart';
import 'package:my_ios_app/presentation/viewModel/workBook/GetParticipatedWorkShopsOfChildUserViewModel.dart';

import '../../../config/apiRoute/BaseUrls.dart';
import '../../../config/apiRoute/child/ChildUrls.dart';
import '../../../core/network/UriCreator.dart';
class AgeRange {
  final int id;
  final String label;
  final RangeValues range;

  AgeRange({
    required this.id,
    required this.label,
    required this.range,
  });
}
class WorkBookUi extends StatefulWidget {
  const WorkBookUi({Key? key}) : super(key: key);
  @override
  _WorkBookUiState createState() => _WorkBookUiState();
}

class _WorkBookUiState extends State<WorkBookUi> {
  AgeRange? selectedRange;
  String? selectedRangeTitle;
  KanoonHttp apiServiceImpl = GetIt.I.get();

  int? idP;
  List<WorkBook> filteredItems = [];
  final List<AgeRange> ageRanges = [
    AgeRange(id: 1, label: '3 تا 3/5 سال', range: RangeValues(3, 3.5)),
    AgeRange(id: 3, label: '3/5 تا 4 سال', range: RangeValues(3.5, 4)),
    AgeRange(id: 6, label: '4 تا 4/5 سال', range: RangeValues(4, 4.5)),
    AgeRange(id: 4, label: '4/5 تا 5 سال', range: RangeValues(4.5, 5)),
    AgeRange(id: 5, label: '5 تا 6 سال', range: RangeValues(5, 6)),
    AgeRange(id: 2, label: '6 تا 7 سال', range: RangeValues(6, 7)),
  ];
  String getNameForSelectedRange(
      RangeValues selectedRange, List<AgeRange> ageRanges) {
    // Loop through the map and find the key for the selected range
    for (var entry in ageRanges) {
      if (entry.range == selectedRange) {
        return entry.label; // Return the key when a match is found
      }
    }
    return 'Unknown'; // Return a default value if no match is found
  }

  void filterItems(List<WorkBook> items) {

    if (selectedRange != null) {
      AgeRange? range = ageRanges.firstWhere(
            (range) => range.id == selectedRange?.id,
   // Handle cases where no matching item is found
      );

      final String name = getNameForSelectedRange(range.range, ageRanges);
      print('filterItems');
      print(name);
      print(items.first.workShopId);
      setState(() {
        selectedRangeTitle = name;
        filteredItems = items
            .where((item) =>
        item.fromAgeDomain! >= range.range.start &&
            item.toAgeDomain! <= range.range.end)
            .toList();
      });
    } else {
      setState(() {
        filteredItems = List.from(items); // Reset to all items
      });
    }
  }
  Uri createUri({String? path, Map<String, dynamic>? body}) {
    return UriCreator.createUriWithUrl(
        url: BaseUrls.baseUrl,
        path: BaseUrls.basePath + (path ?? ''),
        body: body);
  }
  @override
  Widget build(BuildContext context) {

    return CubitProvider(
      create: (context) => NewHomeViewModel(AppState.idle),
      builder: (blocMain, state) {

        if (state.isLoading)
          return Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Color.fromARGB(255, 246, 5, 121),
                size: 45,
              ));

        return FutureBuilder(
            future: blocMain.getChildItem(),
            builder: (context, snapshot) {
              ChildsItem? selectedChild;
              if (snapshot.hasData && snapshot.data is ChildsItem) {
                selectedChild = snapshot.data as ChildsItem;
              }
              if (selectedChild == null) {
                return Center(child: Text("No child selected"));
              }
              print("selectedChildsss");
              print(selectedChild.gender);

              Uint8List bytes =
              base64Decode(selectedChild.childPicture?.content ?? '');

              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: kIsWeb ? 0 : 15,
                        child: Image.asset(
                          'assets/Rectangle21.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      AppBar(
                        title: Text(
                          "report_card".tr,
                          style: TextStyle(
                            fontFamily: 'IRANSansXFaNum',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        iconTheme: IconThemeData(color: Colors.white),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      CubitProvider(
                        create: (context) => NewHomeViewModel(AppState.idle),
                        builder: (blocMain, state) {
                          if (state.isLoading)
                            return LoadingAnimationWidget.hexagonDots(
                              color: Color.fromARGB(255, 246, 5, 121),
                              size: 45,
                            );

                          return CubitProvider(
                            create: (context) =>
                                GetParticipatedWorkShopsOfChildUserViewModel(
                                    AppState.idle),
                            builder: (bloc, state) {
                              if (state.isLoading)
                                return Center(
                                  child: LoadingAnimationWidget.hexagonDots(
                                    color: Color.fromARGB(255, 246, 5, 121),
                                    size: 45,
                                  ),
                                );

                              if (state is Error) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/icons8_folder.png',
                                        width: 150,
                                        height: 150,
                                      ),
                                      Text(
                                        "no_workbook".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'IRANSansXFaNum',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xFF272930),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              print("selectedChild.toString()");

                              print(selectedChild?.childLastName);
                              return ConditionalUI<List<WorkBook>>(
                                state: state,
                                showError: true,
                                onSuccess: (data) {
                                  if (!data.any(
                                          (element) => element.workShopId != -1)) {
                                    data.add(WorkBook(workShopId: -1));
                                  }
                                  final availableRanges = <AgeRange>[];

                                  ageRanges.forEach((AgeRange range) {
                                    if (data.any((item) =>
                                    item.fromAgeDomain! >= range.range.start &&
                                        item.toAgeDomain! <= range.range.end)) {
                                      availableRanges.add(range); // Use 'range.label' or any other unique field instead of 'key'
                                    }
                                  });

                                  if (availableRanges.length <= 1)
                                    filteredItems = data;

                                  return Column(
                                    children: [
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                  //         bytes.length > 10
                                  //             ? Image.memory(
                                  //           bytes,
                                  //           width: 32,
                                  //           height: 32,
                                  //         )
                                  //             :  selectedChild?.gender == null ?SvgPicture.asset(
                                  // './assets/group-60.svg',
                                  // width: 32,
                                  // height: 32,
                                  // ):selectedChild?.gender ==1?Image.asset(
                                  // './assets/girl.png',
                                  // width: 32,
                                  // height: 32,
                                  // ):Image.asset(
                                  // './assets/boy.png',
                                  // width: 32,
                                  // height: 32,
                                  // ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${selectedChild?.childFirstName} ${selectedChild?.childLastName}',
                                            style: TextStyle(
                                              fontFamily: 'IRANSansXFaNum',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Color(0xFF696F82),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '${selectedChild?.childAge ?? ""}',
                                            style: TextStyle(
                                              fontFamily: 'IRANSansXFaNum',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Color(0xFF696F82),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                        if (availableRanges.length > 0)
                                                    DropdownButton<AgeRange>(
                                                      hint: Text(
                                                        'لطفا سن فرزند خود را انتخاب کنید',
                                                        style: TextStyle(
                                                          fontFamily: 'IRANSansXFaNum',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 12,
                                                          color:
                                                          Color.fromARGB(255, 0, 0, 0),
                                                        ),
                                                      ),
                                                      value: selectedRange,
                                                      items: availableRanges
                                                          .map((ageRange) {
                                                        return DropdownMenuItem<AgeRange>(
                                                          value: ageRange,
                                                          child: Text(
                                                            ageRange.label,
                                                            style: TextStyle(
                                                              fontFamily: 'IRANSansXFaNum',
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                              color: Color.fromARGB(
                                                                  255, 49, 49, 49),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (AgeRange? newValue) {
                                                        print(newValue);
                                                        print('"newValue"');

                                                        blocMain.getGeneralReportCardByPacage(newValue!.id.toString());
                                                        setState(() {
                                                          selectedRange = newValue;
                                                          filterItems(data);

                                                        });
                                                      },
                                                    ),
                                      
                                             ConditionalUI<
                                                WorkBookDetailUiModel>(
                                              showError: false,
                                              skeleton: const MyLoaderBig(),
                                              state: blocMain.reportCardState,
                                              onSuccess: (reportCard) {
                                                var dataT =
                                                blocMain.getTotalChartData(
                                                    reportCard.cards,
                                                    reportCard.categories);
                                                         if(selectedRange == null)
                                                         return Column(children: []);

                                                return Column(children: [
                                                
                                                  SizedBox(height: 20),
 
                                                  Container(
                                                    height: 410,
                                                    padding:
                                                    const EdgeInsets.all(8.0),
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
                                                                    child:
                                                                    GroupWidget(
                                                                      assetName:
                                                                      'assets/group-22-4.svg',
                                                                      backgroundColor: Color
                                                                          .fromARGB(
                                                                          255,
                                                                          246,
                                                                          95,
                                                                          92)
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
                                                                    Color.fromARGB(
                                                                        255,
                                                                        248,
                                                                        246,
                                                                        133)
                                                                        .withOpacity(
                                                                        0.3),
                                                                    text: 'workshop_description'
                                                                        .tr, // Use 'workshop_description'.tr if using localization
                                                                  ),
                                                                  GroupWidget(
                                                                    assetName:
                                                                   'assets/group-22.svg',
                                                                    backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        84,
                                                                        163,
                                                                        197)
                                                                        .withOpacity(
                                                                        0.3),
                                                                    text: 'reading_literacy'
                                                                        .tr, // Use 'life_skills'.tr if using localization
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
                                                                    Color.fromARGB(
                                                                        255,
                                                                        220,
                                                                        132,
                                                                        191)
                                                                        .withOpacity(
                                                                        0.3),
                                                                    text: 'art'
                                                                        .tr, // Use 'art'.tr if using localization
                                                                  ),
                                                                  GroupWidget(
                                                                    assetName:
                                                                    'assets/group-22-5.svg',
                                                                    backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        253,
                                                                        154,
                                                                        149)
                                                                        .withOpacity(
                                                                        0.3),
                                                                    text: 'life_skills'
                                                                        .tr , // Use 'reading_literacy'.tr if using localization
                                                                  ),
                                                                ],
                                                              ),

                                                              SizedBox(
                                                                  height:
                                                                  20), // Space between legend and previous rows

                                                              // Legend widgets
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  LegendWidget(
                                                                    color: Color(
                                                                        0xFF3D9C68),
                                                                    text: 'first_assessment'
                                                                        .tr, // Use 'first_assessment'.tr if using localization
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                      20), // Space between legends
                                                                  LegendWidget(
                                                                    color: Color(
                                                                        0xFFF15B67),
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
                                                              spaceCount: dataT
                                                                  .maxValue <
                                                                  5
                                                                  ? dataT.maxValue
                                                                  : dataT.maxValue ~/
                                                                  5,
                                                              labelWidth: 0,
                                                              labelColor:
                                                              Color.fromARGB(0, 255, 255, 255),
                                                              textScaleFactor:
                                                              .03,
                                                              strokeColor:
                                                              Colors.grey,
                                                           
                                                              values: [
                                                                ChartModel(
                                                                  values: dataT
                                                                      .values
                                                                      .first,
                                                                  color: Color
                                                                      .fromARGB(
                                                                      255,
                                                                      0,
                                                                      154,
                                                                      18),
                                                                ),
                                                                if (dataT.values
                                                                    .length >
                                                                    1)
                                                                  ChartModel(
                                                                    values: dataT
                                                                        .values
                                                                        .last,
                                                                    color: Color
                                                                        .fromARGB(
                                                                        255,
                                                                        255,
                                                                        60,
                                                                        0),
                                                                  ),
                                                              ],
                                                              labels: dataT.name,
                                                              maxValue: dataT
                                                                  .maxValue
                                                                  .toDouble(),
                                                              fillColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  37,
                                                                  169,
                                                                  0),
                                                              maxLinesForLabels:
                                                              1,
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
                                                            'Graphical_report_card'
                                                                .tr,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'IRANSansXFaNum',
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 13,
                                                              color: Color(
                                                                  0xFF272930),
                                                            ),
                                                            textAlign:
                                                            TextAlign.center,
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                                  ) ],) ;
                                              },
                                            ),
                                          
                                      SizedBox(
                                          height:
                                          20),
                                      Text(
                                        "select_workshop".tr,
                                        style: TextStyle(
                                          fontFamily: 'IRANSansXFaNum',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0xFF272930),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 12),
                                      if(selectedRange != null)
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: filteredItems.length,
                                        itemBuilder: (context, index) {
                                          if (filteredItems[index].workShopId ==
                                              -1) {
                                            return const SizedBox(height: 50);
                                          }
                                          return Column(
                                            children: [
                                              buildWorkshopSelection(
                                                '${filteredItems[index].workShopTitle?.replaceAll('کارگاه','کارنامه')}',
                                                filteredItems[index]
                                                    .workShopFileContent ??
                                                    '',
                                                Color(0xFF82B5CA),
                                                    () {
                                                  num? lastId;
                                                  String? lastAgeDomain;
                                                  for (var element in data) {
                                                    double pAge =
                                                        double.tryParse(element
                                                            .toAgeDomain
                                                            .toString()) ??
                                                            0.0;
                                                    double cAge =
                                                        double.tryParse(data[
                                                        index]
                                                            .toAgeDomain
                                                            .toString()) ??
                                                            0.0;
                                                    if (element.workShopFileContent ==
                                                        filteredItems[index]
                                                            .workShopFileContent &&
                                                        pAge < cAge) {
                                                      lastId =
                                                          element.workShopId;
                                                      lastAgeDomain = element
                                                          .packageAgeDomain;
                                                    }
                                                  }
                                                  bloc.gotoDetailView(
                                                      filteredItems[index]
                                                          .workShopId,
                                                      lastId: lastId,
                                                      lastAgeDomain:
                                                      lastAgeDomain,idPack: selectedRange?.id.toString());
                                                },
                                              ),
                                              SizedBox(height: 12),
                                            ],
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                        const Divider(),
                                      ),

                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget buildWorkshopSelection(String title, String iconPath,
      Color backgroundColor, Function() onSelect) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Image.memory(
                base64Decode(iconPath),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'IRANSansXFaNum',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF272930),
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              // decoration: BoxDecoration(
              //   color: backgroundColor.withOpacity(0.3),
              //   borderRadius: BorderRadius.circular(8),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
