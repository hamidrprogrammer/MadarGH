
import 'package:my_ios_app/config/apiRoute/BaseUrls.dart';

class UriCreator {
  static Uri createUri({String? path, Map<String, dynamic>? body}) {
    return Uri.https(BaseUrls.baseUrl, path ?? '', body);
  }

  static Uri createUriWithUrl({String? url,String? path, Map<String, dynamic>? body}) {
    return Uri.https(url ?? '', path ?? '', body);
  }
}
