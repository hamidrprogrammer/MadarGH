import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/viewModel/workBook/TotalWorkBookViewModel.dart';
import 'package:sprintf/sprintf.dart';

class TotalWorkBookChartUi extends StatelessWidget {
  const TotalWorkBookChartUi({
    Key? key,
    this.cards,
    required this.title,
    required this.categories,
  }) : super(key: key);
  final List<GeneralReportCard>? cards;
  final List<WorkShopCategory> categories;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => TotalWorkBookViewModel(AppState.idle),
      builder: (bloc, state) {
        var data = bloc.getTotalChartData(cards ?? [], categories);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  List<String> workShops = bloc.getUserWorkShops(cards);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIndicatorTextRow(
                        context: context,
                        iconColor: Colors.red,
                        text: sprintf(title, [
                          workShops.toSet().toList().length.toString(),
                          categories.length.toString()
                        ]),
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      _buildIndicatorTextRow(
                        context: context,
                        iconColor: Colors.green,
                        text: sprintf('learning_type_sprintf'.tr, [
                          categories.length.toString(),
                          categories.map((e) => e.name).toList().join(', ')
                        ]),
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      _buildIndicatorTextRow(
                        context: context,
                        iconColor: Colors.green,
                        text: sprintf('courses_count_sprintf'.tr, [
                          workShops.toSet().toList().length.toString(),
                          workShops.toSet().toList().join(', ')
                        ]),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'general_performance_report'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold,   fontFamily: 'IRANSansXFaNum',),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.fill,
                child: RadarChart(
                  spaceCount: (data.last.maxValue ?? 1) ~/ 5,
                  textScaleFactor: .03,
                  strokeColor: Colors.grey,
                  values: [
                    if (data.first.values.first.isNotEmpty)
                      ChartModel(
                          values: data.first.values.first, color: Colors.blue),
                    if (data.length > 1)
                      ChartModel(
                          values: data.last.values.first, color: Colors.green),
                  ],
                  labels: data.last.name,
                  maxValue: data.last.maxValue.toDouble(),
                  maxLinesForLabels: 2,
                  maxWidth: MediaQuery.of(context).size.width - 100,
                  maxHeight: MediaQuery.of(context).size.width - 100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIndicatorTextRow({
    required BuildContext context,
    required Color iconColor,
    required String text,
    TextStyle? style,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: iconColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            style: style,
          ),
        ),
      ],
    );
  }
}
