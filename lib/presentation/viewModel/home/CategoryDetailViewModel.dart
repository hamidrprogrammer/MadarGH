import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/home/CategoryDetailResponse.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/home/CategoryDetailUseCase.dart';

class CategoryDetailViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  late String? id;
  DetailImages images = DetailImages(images: []);


  CategoryDetailViewModel(super.initialState) {
    getExtra();
  }

  void getExtra() {
    id = _navigationServiceImpl.getArgs();
    if (id != null && id is String) {
      CategoryDetailUseCase().invoke(MyFlow(
        flow: (appState) async {
          if (appState.isSuccess &&
              appState.getData is CategoryDetailResponse) {
            await declareImages(appState.getData);
          }
          updateState(appState);
        },
      ), data: id);
    }
  }

  declareImages(CategoryDetailResponse response) async {
    var headerImg = response.parentCategoryFiles?.firstWhereOrNull((
        element) => element.location == 1);
    if (headerImg != null && headerImg.file?.content != null) {
      images.headerImage = headerImg.file?.content;
    }
    images.images =
        response.parentCategoryFiles?.where((element) => element.file?.content != null && element.location == 2)
            .map((e) => e.file?.content ?? '').toList() ?? [];
  }
}

class DetailImages {
  String? headerImage;
  List<String> images;

  DetailImages({
    this.headerImage,
    required this.images,
  });
}
