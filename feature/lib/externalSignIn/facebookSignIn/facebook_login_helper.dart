// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
//
// class FacebookLoginHelper{
//   // Create a singleton instance
//   static final FacebookLoginHelper _instance = FacebookLoginHelper._();
//   factory FacebookLoginHelper() => _instance;
//   FacebookLoginHelper._();
//
// // Create a FacebookAuth instance
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//
// // Get the current access token
//   Future<AccessToken?> get currentAccessToken => _facebookAuth.accessToken;
//
// // Login with Facebook
//   Future<LoginResult> login() async {
//     return await _facebookAuth.login();
//   }
//
// // Logout from Facebook
//   Future<void> logout() async {
//     await _facebookAuth.logOut();
//   }
//
// // Get user data
//   Future<Map<String, dynamic>> getUserData() async {
//     return await _facebookAuth.getUserData();
//   }
// }