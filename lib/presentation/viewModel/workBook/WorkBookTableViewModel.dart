import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookTableModel.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class WorkBookTableViewModel extends BaseViewModel {
  WorkBookTableViewModel(super.initialState);

  List<DataColumn> getColumnData(List<WorkShopCategory> categories) {
    var label = WorkShopCategory(name: 'workshop'.tr, id: '-1');
    return [getDataColumn(label)] +
        categories.map((category) => getDataColumn(category)).toList();
  }

  DataColumn getDataColumn(WorkShopCategory category) {
    return DataColumn(
      label: Expanded(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Center(
            child: Padding(
              padding: 8.dpe,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1,
                style: TextStyle(fontSize: WidgetSize.smallTitle,   fontFamily: 'IRANSansXFaNum',),
              ),
            ),
          ),
        ),
      ),
    );
  }


  List<DataRow> getCellsData(List<WorkShopCategory> categories,List<List<WorkBookTableModel>> tableData){
    categories = [WorkShopCategory(name: '', id: '-1')] + categories;
    return tableData
        .map(
          (workShops) => DataRow(
        cells: categories.map((category) {
          var item = workShops.firstWhereOrNull((element) => category.id.toString() == element.id);
          if(category.id == '-1') return getCell(tableData,workShops);
          return DataCell(
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                    item?.value ?? 'not_done'.tr,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                    style: TextStyle(color: item == null ? Colors.red : Colors.black,fontSize: WidgetSize.smallTitle,
                       fontFamily: 'IRANSansXFaNum',),
                  ),),
            ),
          );
        }).toList(),
      ),
    )
        .toList();
  }

  DataCell getCell(List<List<WorkBookTableModel>> tableData, List<WorkBookTableModel> workShops) {
    var index = tableData.indexOf(workShops) + 1;
    return DataCell(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            '${'assessment'.tr} $index',
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(color: Colors.black,fontSize: WidgetSize.smallTitle,   fontFamily: 'IRANSansXFaNum',),
          ),),
      ),
    );
  }
  
}
