import 'package:core/dioNetwork/response/KanoonHttpResponse.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';

abstract class ErrorHandlerRepository {
  ErrorModel makeError(KanoonHttpResponse response);

  ErrorModel makeErrorByStatusCode(int statusCode);
}
