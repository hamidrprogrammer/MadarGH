import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/app/home_slider_UseCase.dart';

class HomeSliderViewModel extends BaseViewModel {
  HomeSliderViewModel(super.initialState) {
    HomeSliderUseCase().invoke(mainFlow);
  }
}
