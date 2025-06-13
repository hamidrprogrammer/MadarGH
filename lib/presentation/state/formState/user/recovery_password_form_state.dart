import 'package:my_ios_app/data/body/user/recoveryPassword/RecoveryPasswordBody.dart';

class RecoveryPasswordFormState {
  String username, password, confirmPassword, activationCode;

  RecoveryPasswordFormState({
    this.username = '',
    this.activationCode = '',
    this.password = '',
    this.confirmPassword = '',
  });

  RecoveryPasswordBody createBody() {
    return RecoveryPasswordBody(
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        activationCode: activationCode);
  }
}
