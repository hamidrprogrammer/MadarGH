import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/child/GetAllUserChilPackageResponse.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/child/GetAllUserChildWithPackagesUseCase.dart';
import 'package:my_ios_app/useCase/subscribe/GetSubscribeUseCase.dart';

class PackagesViewModel extends BaseViewModel {
  AppState packagesState = AppState.idle;
  List<ChildPackage> childPackages = List.empty(growable: true);

  PackagesViewModel(super.initialState) {
    getPackages();
  }

  void getPackages() {
    GetSubscribeUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        getChildrensPackage();
      }
      packagesState = appState;
      refresh();
    }));
  }

  void getChildrensPackage() {
    GetAllUserChildWithPackages().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess) {
        if (appState.getData is List<ChildPackage>) {
          childPackages = appState.getData;
          refresh();
        }
      }
    }));
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  ChildPackage? getChildPackageData(String subscribeId) {
    return childPackages.firstWhereOrNull(
        (element) => element.packages?.id?.toString() == subscribeId);
  }
}
