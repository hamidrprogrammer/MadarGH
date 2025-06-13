import 'package:dio/dio.dart';

class KanoonHttpResponse {
  final int responseStatusCode;
  final String responseBody;
  final dynamic data;

  int get statusCode => responseStatusCode;

  String get body => responseBody;

  const KanoonHttpResponse({
    required this.responseBody,
    required this.responseStatusCode,
    required this.data,
  });
}

extension KanoonHttpExtension on Response {

  KanoonHttpResponse get createKanoonResponse => KanoonHttpResponse(
      responseBody: toString(), responseStatusCode: statusCode ?? 0,data: data);
}


extension KanoonHttpExtension2 on KanoonHttpResponse{
  bool get isSuccessful => statusCode == 200;
}