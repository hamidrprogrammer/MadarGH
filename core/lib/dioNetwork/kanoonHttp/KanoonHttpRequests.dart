import 'package:core/dioNetwork/response/KanoonHttpResponse.dart';
import 'package:dio/dio.dart';

abstract class KanoonHttpRequests {
  Future<KanoonHttpResponse> get<T>(Uri uri,{Options? options});

  Future<KanoonHttpResponse> post(Uri uri, {Object? data,Options? options});

  Future<Response<dynamic>> request(String path, {Object? data, Map<String,
      dynamic>? queryParameters, Options? options,});
}
