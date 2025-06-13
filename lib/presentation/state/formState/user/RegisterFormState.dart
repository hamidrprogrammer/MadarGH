import 'package:my_ios_app/data/body/user/register/SignUpBody.dart';

class RegisterFormState {
  String firstName, lastName, password, confirmPassword;
  String? mobile;
  String? email;
  String? firstNameError,
      lastNameError,
      mobileError,
      passwordError,
      confirmPasswordError,
      emailError,
      termsError;
  String? token;

  RegisterFormState({
    this.firstName = '',
    this.firstNameError,
    this.lastName = '',
    this.lastNameError,
    this.mobile,
    this.mobileError,
    this.email,
    this.emailError,
    this.password = '',
    this.passwordError,
    this.confirmPassword = '',
    this.confirmPasswordError,
    this.termsError,
    this.token,
  });

  SignUpBody getBody() {
    return SignUpBody(
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      password: password,
      confirmPassword: confirmPassword,
      email: email,
      ReCaptchaToken: token,
    );
  }
}
