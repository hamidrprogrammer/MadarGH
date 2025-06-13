import 'package:my_ios_app/data/serializer/child/ChildsResponse.dart';
import 'package:my_ios_app/data/serializer/home/CategoryResponse.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/ChartDataModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/home/GetAllCategoriesUseCase.dart';

class CategoriesViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  CategoriesViewModel(super.initialState) {
    getCategories();
  }
  Future<ChildsItem?> getChildItem() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = "";

    if (jsonString != null) {
      List<ChildsItem> items = childsItemFromJson(jsonString);
      return items.isNotEmpty
          ? items.first
          : null; // Return the first item or null if the list is empty
    } else {
      return null; // Return null if no data is found
    }
  }

  void getCategories() {
    GetAllCategoriesUseCase().invoke(mainFlow);
  }

  void gotoDetail(String? id) {
    if (id != null) {
      _navigationServiceImpl.navigateTo(AppRoute.categoryDetail, id);
    }
  }

  ChartDataModel getTotalChartData(
      List<GeneralReportCard>? cards, List<Category> categories) {
    List<String> names = categories.map((e) => e.title ?? '').toList();
    var maxValue = cards?.fold(
            0,
            (previousValue, element) =>
                previousValue > element.workShopReportCards.getMaxValue
                    ? previousValue
                    : element.workShopReportCards.getMaxValue) ??
        0;

    List<String> lableData = [];
    List<double> values = categories.map((e) {
      var id = e.id ?? 0;
      var currentValue = getTotalWorkBookThirdRate(id, cards);
      var correct = currentValue?.thirdRateAnswersCount ?? 0;
      var all = currentValue?.allQuestionsCount ?? 0;
      lableData.add('$correct از $all');
      var result = (all == 0 ? 0 : (maxValue * correct) / all).toDouble();
      return result;
    }).toList();

    return ChartDataModel(
        maxValue: maxValue,
        name: names,
        values: [values],
        lableData: lableData);
  }

  WorkShopReportCard? getTotalWorkBookThirdRate(
      int id, List<GeneralReportCard>? cards) {
    WorkShopReportCard? value;
    cards?.forEach((e) {
      e.workShopReportCards?.forEach((element) {
        if (id.toString() ==
            element.workShopDictionary?.categoryId?.toString()) {
          value = element;
        }
      });
    });
    return value;
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
