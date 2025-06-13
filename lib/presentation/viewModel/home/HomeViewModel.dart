import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/home/HomeUseCase.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(super.initialState) {
    // getRemainingDay();
    // getChildOfUser();
    // GetIt.I.get<MyNotification>().publish('MainViewModel', '5');
    // getHomeData();
  }

  void getHomeData() {
    HomeUseCase().invoke(mainFlow);
  }
}
