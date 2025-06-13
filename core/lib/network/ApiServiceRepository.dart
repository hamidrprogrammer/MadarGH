import 'package:http/http.dart';

abstract class ApiServiceRepository{
  Future<Response> post(Uri uri);
  Future<Response> post2(Uri uri,Object body);
  Future<Response> get(Uri uri);
}