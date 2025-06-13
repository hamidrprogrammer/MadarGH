import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class TotalWorkBookViewModel extends BaseViewModel {
  TotalWorkBookViewModel(super.initialState);

  List<ChartDataModel> getTotalChartData(
      List<GeneralReportCard>? cards, List<WorkShopCategory> categories) {
    List<String> names = categories.map((e) => e.name).toList();
    var maxValue = cards?.fold(
            0,
            (previousValue, element) =>
                previousValue > element.workShopReportCards.getMaxValue
                    ? previousValue
                    : element.workShopReportCards.getMaxValue) ??
        0;

    List<String> lableData = [];
    List<ChartDataModel> charts = [];
    List<double> values = categories.map((e) {
      var id = e.id;

      var correct = 0;

      var all = 0;

      var firstCurrentValues = getTotalWorkBookThirdRate(id, cards?.first);
      firstCurrentValues?.map((e) {
        correct += e.thirdRateAnswersCount ?? 0;
        all += e.allQuestionsCount ?? 0;
      }).toList();
      lableData.add('$correct ${'from'.tr} $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();

    charts.add(ChartDataModel(
        maxValue: maxValue,
        name: names,
        values: [values],
        lableData: lableData));

    values = categories.map((e) {
      var id = e.id;

      var correct = 0;

      var all = 0;

      var firstCurrentValues = getTotalWorkBookThirdRate(id, cards?.last);
      firstCurrentValues?.map((e) {
        correct += e.thirdRateAnswersCount ?? 0;
        all += e.allQuestionsCount ?? 0;
      }).toList();
      lableData.add('$correct ${'from'.tr} $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();

    charts.add(ChartDataModel(
        maxValue: maxValue,
        name: names,
        values: [values],
        lableData: lableData));

    return charts;
  }

  List<WorkShopReportCard>? getTotalWorkBookThirdRate(
      String id, GeneralReportCard? card) {
    List<WorkShopReportCard> values = [];
    card?.workShopReportCards?.forEach((element) {
      if (id.toString() == element.workShopDictionary?.categoryId?.toString()) {
        values.add(element);
      }
    });

    return values;
  }

  List<String> getUserWorkShops(List<GeneralReportCard>? cards) {
    List<String> workShops = [];
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        workShops.add(element.workShopDictionary?.name ?? '');
      });
    });
    return workShops;
  }
}
