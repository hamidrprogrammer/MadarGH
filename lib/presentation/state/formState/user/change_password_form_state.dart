import 'package:my_ios_app/data/body/user/changePassword/ChangePasswordBody.dart';

class ChangePasswordFormState {
  String mobile, currentPassword, password, confirmPassword;

  ChangePasswordFormState({
    this.mobile = '',
    this.currentPassword = '',
    this.password = '',
    this.confirmPassword = '',
  });

  ChangePasswordBody createBody(){
    return ChangePasswordBody(CurrentPassword: currentPassword, NewPassword: password, ConfirmNewPassword: confirmPassword);
  }
}
