import 'package:my_ios_app/config/apiRoute/payment/PayOrderUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class PayOrderResultByCafeBazaarUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data, Object? orderId}) async {
    assert(data != null && data is int);
    try {
      flow.emitLoading();

      var uri = createUri(
          path: PayOrderUrls.payOrderResultByCafeBazaar,
          body: {'amount': data.toString(), "orderId": orderId.toString()});
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {
          if (result.result != null) {
            flow.emitData('');
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
