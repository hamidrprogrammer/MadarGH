import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/location/provinces_use_case.dart';

class LocationViewModel extends BaseViewModel {
  LocationViewModel(super.initialState);

  AppState pState = AppState.idle;

  void fetchProvinces() {
    ProvinceUseCase().invoke(MyFlow(flow: (appState) {
      pState = appState;
      refresh();
    }));
  }
}
