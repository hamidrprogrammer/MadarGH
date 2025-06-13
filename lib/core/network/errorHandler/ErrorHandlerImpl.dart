import 'package:core/dioNetwork/response/KanoonHttpResponse.dart';

import 'ErrorHandlerImpl.dart';

export 'ErrorModel.dart';
export 'common/ErrorMessages.dart';
export 'errorHandlerRepository.dart';

class ErrorHandlerImpl extends ErrorHandlerRepository {
  @override
  ErrorModel makeError(KanoonHttpResponse response) {
    return createErrorByStatusCode(response.statusCode);
  }

  ErrorModel createErrorByStatusCode(int statusCode) {
    switch (statusCode) {
      case 200:
        return ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages().ErrorMessage_App);
      case 422:
        return ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages().ErrorMessage_4_2_2);
      case 401:
        return ErrorModel(
            state: ErrorState.UnAuthorization,
            message: ErrorMessages().ErrorMessage_4_0_1);
      case 302:
        print("40000000000000000000000000000000000000000000000000004");
        return ErrorModel(
            state: ErrorState.Message, message: ErrorMessages().NOT_FOUND);
      case 404:
        print("40000000000000000000000000000000000000000000000000004");
        return ErrorModel(
            state: ErrorState.Message, message: ErrorMessages().NOT_FOUND);
      case 500:
        return ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages().ErrorMessage_5_0_0);
      default:
        return ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages().ErrorMessage_Connection);
    }
  }

  @override
  ErrorModel makeErrorByStatusCode(int statusCode) {
    return createErrorByStatusCode(statusCode);
  }
}
