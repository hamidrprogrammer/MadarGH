import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/body/user/changePassword/ChangePasswordBody.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class ChangePasswordUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is ChangePasswordBody);

    try {
      flow.emitLoading();

      var uri = createUri(path: UserUrls.postChangePassword);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.throwMessage(result.concatSuccessMessages);
        } else {
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch(e);
    }
  }
}
