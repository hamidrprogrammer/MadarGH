import 'package:my_ios_app/config/apiRoute/home/HomeUrls.dart';
import 'package:my_ios_app/data/serializer/home/CategoryDetailResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class CategoryDetailUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);

    try {
      flow.emitLoading();

      var uri = createUri(
          path: HomeUrls.getCategoryDetails, body: {'categoryId': data});

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (response.isSuccessful) {
          flow.emitData(categoryDetailResponseFromJson(result.result));
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
