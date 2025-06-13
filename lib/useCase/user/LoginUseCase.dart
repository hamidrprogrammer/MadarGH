import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/body/user/login/LoginBody.dart';
import 'package:my_ios_app/data/serializer/user/User.dart';
import 'package:my_ios_app/presentation/state/formState/user/LoginFormState.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginUseCase extends BaseUseCase {
  LoginUseCase.initFormState({required this.loginFormState});

  LoginFormState loginFormState;

  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      LoginBody loginBody = LoginBody(
        username: loginFormState.username,
        password: loginFormState.password,
      );

      Uri uri = createUri(path: UserUrls.signIn);
      var response =
          await apiServiceImpl.post(uri, data: jsonEncode(loginBody));
      if (response.isSuccessful) {
        print(response.result);
        var result = response.result;
        print(result.isSuccessFull);
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
        print("EEEEEEEEEEEEEEEEEEEEEEEEEE");
        flow.throwError(response);
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEEEEEEEE");
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}