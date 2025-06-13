import 'package:my_ios_app/config/apiRoute/payment/PayOrderUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class PayOrderUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is bool);
    try {
      flow.emitLoading();

      var uri = createUri(
          path: PayOrderUrls.payOrder, body: {'useZarinPal': "true"});

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {
          if (result.result != null) {
            flow.emitData(result.result.replaceAll('"', ""));
          } else {
            flow.successMessage(result.concatSuccessMessages);
          }
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
