import 'package:core/dioNetwork/interceptor/AuthorizationInterceptor.dart';
import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/serializer/user/User.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class RefreshUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      Uri uri = createUri(path: UserUrls.refreshToken);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 406) {
          flow.emitData(jsonDecode(result.result)['id'].toString() ?? '');
        } else {
          if (result.isSuccessFull || result.resultCode == 0) {
            flow.emitData(userFromJson(result.result ?? ''));
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
