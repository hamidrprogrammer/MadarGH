import 'package:my_ios_app/config/apiRoute/app/AppUrls.dart';
import 'package:my_ios_app/data/serializer/home/slider/slider_content_response.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class HomeSliderUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: AppUrls.getSliders);

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {
          flow.emitData(sliderContentFromJson(result.result));
        } else {
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}
