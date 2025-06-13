import 'package:flutter/material.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/state/app_state.dart';
import 'package:my_ios_app/presentation/ui/main/CubitProvider.dart';
import 'package:my_ios_app/presentation/ui/main/UiExtension.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookTableModel.dart';
import 'package:my_ios_app/presentation/viewModel/workBook/WorkBookTableViewModel.dart';

class WorkBookTableUi extends StatelessWidget {
  const WorkBookTableUi({
    Key? key,
    required this.tableData,
    required this.categories,
  }) : super(key: key);
  final List<List<WorkBookTableModel>> tableData;
  final List<WorkShopCategory> categories;

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
      create: (context) => WorkBookTableViewModel(AppState.idle),
      builder: (bloc, state) {
        return Container(
          margin: 16.dpe,
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: DataTable(
              horizontalMargin: 0.0,
              border:
                  TableBorder.all(color: Colors.grey, borderRadius: 8.bRadius),
              columnSpacing: 0.0,
              columns: bloc.getColumnData(categories),
              rows: bloc.getCellsData(categories, tableData),
            ),
          ),
        );
      },
    );
  }
}
