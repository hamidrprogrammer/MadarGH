import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

import '../../data/body/user/register/SignUpBody.dart';

class SignUpUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is SignUpBody);
    try {
      flow.emitLoading();
      var uri = createUri(path: UserUrls.signUp);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 406) {
          flow.emitData(jsonDecode(result.result)['id'].toString());
        } else {
          if (result.isSuccessFull) {
            flow.emitData(jsonDecode(result.result)['id'].toString());
          } else {
            flow.throwMessage(result.concatErrorMessages);
          }
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
