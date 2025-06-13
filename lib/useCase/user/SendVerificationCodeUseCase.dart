import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/body/user/login/LoginBody.dart';
import 'package:my_ios_app/data/serializer/user/User.dart';
import 'package:my_ios_app/presentation/state/formState/user/LoginFormState.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class SendVerificationUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      assert(data != null && data is String);
      flow.emitLoading();
      Uri uri = createUri(
          path: UserUrls.postSendActivationCode, body: {'userId': data});
      var response = await apiServiceImpl.post(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData('');
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
