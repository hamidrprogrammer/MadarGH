class UriCreator {
  static Uri createUriWithUrl(
      {String? url, String? path, Map<String, dynamic>? body}) {
    // return Uri.https(url ?? '', path ?? '', body);
    return Uri.https(url ?? '', path ?? '', body);
  }
}
