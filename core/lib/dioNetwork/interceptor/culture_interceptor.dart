import 'package:dio/dio.dart';

import 'KanoonHttoInterceptor.dart';

class CultureInterceptor extends KanoonHttpInterceptor{
  CultureInterceptor({required this.culture});
  String culture;
  void setCulture(String newCulture){
    culture = newCulture;
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['culture'] = culture;
    super.onRequest(options, handler);
  }
}