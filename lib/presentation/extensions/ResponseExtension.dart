import 'package:http/http.dart';
import 'package:my_ios_app/data/serializer/BaseResponse.dart' as base;

extension ResponseExtension on Response {
  bool get isSuccessful => statusCode == 200;

  base.BaseResponse get result => base.baseResponseFromJson(body);
}

extension BaseResponseExtensions on base.BaseResponse{
  bool get isSuccessFull => resultFlag == true;
  String get concatSuccessMessages => messages?.join('\n') ?? '';
  String get concatErrorMessages => errorMessages?.join('\n') ?? '';
}