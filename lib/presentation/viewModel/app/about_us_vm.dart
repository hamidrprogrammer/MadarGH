import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/app/about_UseCase.dart';

class AboutUsViewModel extends BaseViewModel {
  AboutUsViewModel(super.initialState) {
    getAboutUsData();
  }

  getAboutUsData() {
    AboutUseCase().invoke(mainFlow);
  }
}
