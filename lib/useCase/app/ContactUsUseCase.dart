import 'package:my_ios_app/config/apiRoute/app/AppUrls.dart';
import 'package:my_ios_app/data/body/app/ContactUsBody.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class ContactUsUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is ContactUsBody);

    try {
      flow.emitLoading();
      var uri = createUri(path: AppUrls.contactUs);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          Logger.d('success');
          flow.emitData('data');
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
