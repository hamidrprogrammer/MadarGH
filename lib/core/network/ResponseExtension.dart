import 'package:core/dioNetwork/network.dart';
import 'package:my_ios_app/data/serializer/BaseResponse.dart';

extension ResponseExtension on KanoonHttpResponse {
  BaseResponse get result => baseResponseFromJson(body);
}

extension BaseResponseExtensions on BaseResponse {
  bool get isSuccessFull => resultFlag == true;

  String get concatSuccessMessages => messages?.join('\n') ?? '';

  String get concatErrorMessages => errorMessages?.join('\n') ?? '';
}
