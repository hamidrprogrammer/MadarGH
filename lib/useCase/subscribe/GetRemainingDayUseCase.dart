import 'package:my_ios_app/config/apiRoute/subscribe/SubscribeUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetRemainingDayUseCase extends BaseUseCase {
  Future<String> fetchRemainingDay() async {
    try {
      Uri uri = createUri(path: SubscribeUrls.getRemainingDay);
      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          return result.result ?? "0"; // Return the result or "0" if null
        } else {
          return "0";
        }
      } else {
        return "0";
      }
    } catch (e) {
      return "0"; // Return error message as string
    }
  }

  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      Uri uri = createUri(path: SubscribeUrls.getRemainingDay);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(result.result);
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
  void invokeSupport(MyFlow<AppState> flow) async {
    try {
      flow.emitLoading();
      Uri uri = createUri(path: SubscribeUrls.getRemainingSupport);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(result.result);
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
