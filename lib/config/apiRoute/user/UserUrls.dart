class UserUrls {
  static const signIn = "/Authentication/Login";
  static const refreshToken = "/Authentication/SetNewRefreshToken";
  static const getUserInfo = "/User/GetUserDetailsForUpdateDataInApplication";

  static const information = "/User/UpdateUserInApplication";
  static const signUp = "/User/PostRegister";
  static const getInformation =
      "/User/GetUserDetailsForUpdateDataInApplication";
  static const gtUserDetails = "/User/GetUserDetails";
  static const getUserInfoFromToken = "/User/GetUserInfoFromToken";

  static const forgetPsw = "/User/PostForgotPassword";
  static const confirmCode = "/User/PostChangePassword";
  static const postRecoveryPassword = "/User/PostRecoveryPassword";
  static const postChangePassword = "/User/PostChangePassword";
  static const verification = "/User/PostActivateAccount";
  static const setUserAvatar = "/User/SetUserAvatar";
  static const getUserProfile = "/User/GetUserProfile";
  static const postSendActivationCode = "/User/PostSendActivationCode";
}
