import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';

class MotherWorkBookViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  MotherWorkBookViewModel(super.initialState);

  void gotoDetailView() {
    _navigationServiceImpl.navigateTo(AppRoute.workBookDetail);
  }
}
