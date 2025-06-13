import 'package:my_ios_app/config/apiRoute/subscribe/SubscribeUrls.dart';
import 'package:my_ios_app/data/serializer/subscribe/SubscribesResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetSubscribeUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      Uri uri = createUri(path: SubscribeUrls.getSubscribe);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(subscribesResponseFromJson(result.resultsList));
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
