import 'package:my_ios_app/config/apiRoute/workBook/WorkBookUrls.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBooksResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetParticipatedWorkShopsOfChildUserUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);

    try {
      flow.emitLoading();

      var uri = createUri(
          path: WorkBookUrls.getParticipatedWorkShopsOfChildUser,
          body: {'userChildId': data});

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(workBooksFromJson(result.resultsList));
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
