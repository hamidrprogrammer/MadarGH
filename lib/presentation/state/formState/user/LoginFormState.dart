class LoginFormState {
  LoginFormState({
    this.username = '',
    this.mobileError,
    this.password = '',
    this.passwordError,
  });

  String username;
  String? mobileError, emailError;
  String password;
  String? passwordError;
}
