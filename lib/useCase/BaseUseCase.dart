import 'package:core/dioNetwork/network.dart';
import 'package:feature/navigation/NavigationService.dart';
import 'package:feature/session/LocalSessionImpl.dart';
import 'package:my_ios_app/config/appData/route/AppRoute.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorHandlerImpl.dart';
import 'package:my_ios_app/core/network/errorHandler/ErrorModel.dart';
import 'package:my_ios_app/core/network/errorHandler/common/ErrorMessages.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

export 'dart:convert';

export 'package:core/dioNetwork/response/KanoonHttpResponse.dart';
export 'package:core/network/ApiServiceImpl.dart';
export 'package:core/network/UriCreator.dart';
export 'package:core/utils/flow/MyFlow.dart';
export 'package:core/utils/logger/Logger.dart';
export 'package:get_it/get_it.dart';
export 'package:my_ios_app/config/apiRoute/BaseUrls.dart';
export 'package:my_ios_app/core/network/ResponseExtension.dart';
export 'package:my_ios_app/presentation/state/app_state.dart';

abstract class BaseUseCase {
  KanoonHttp apiServiceImpl = GetIt.I.get();
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();

  void invoke(MyFlow<AppState> flow, {Object? data});

  Uri createUri({String? path, Map<String, dynamic>? body}) {
    return UriCreator.createUriWithUrl(
        url: BaseUrls.baseUrl,
        path: BaseUrls.basePath + (path ?? ''),
        body: body);
  }
}

extension FlowExtension on MyFlow<AppState> {
  void throwCatch(e) {
    final message = e.toString();

    print("statusCode==============" + message.toString());
    if (message.contains('401')) {
      emit(
        AppState.error(
          ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages().ErrorMessage_4_0_1,
          ),
        ),
      );
      final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

      // Clear the local session data
      final session = GetIt.I.get<LocalSessionImpl>(); // Get session instance
      session.clearSession();

      // Emit a state that indicates a need to redirect to the login screen
      _navigationServiceImpl.replaceTo(AppRoute.splash);
    } else {
      // emit(
      //   AppState.error(
      //     ErrorModel(
      //       state: ErrorState.Message,
      //       message: ErrorMessages().ErrorMessage_Connection,
      //     ),
      //   ),
      // );
    }
  }

  void throwError(KanoonHttpResponse? response, {int? statusCode}) {
    print("statusCode==============");
    print(statusCode);

    if (response?.responseStatusCode == 401 ||
        response?.responseStatusCode == 402 ||
        statusCode == 401 ||
        statusCode == 402) {
      final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

      // Clear the local session data
      final session = GetIt.I.get<LocalSessionImpl>(); // Get session instance
      session.clearSession();

      // Emit a state that indicates a need to redirect to the login screen
      _navigationServiceImpl.replaceTo(AppRoute.splash);

      return; // Exit the method after handling the redirect
    }

    if (response != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeError(response),
        ),
      );
    }
    if (statusCode != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeErrorByStatusCode(statusCode),
        ),
      );
    }
  }

  void throwMessage(String msg) {
    print("EEEEEEEEEEEEEEEEEr");
    emit(
      AppState.error(ErrorModel(state: ErrorState.Message, message: msg)),
    );
  }

  void successMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.SuccessMsg, message: msg)),
    );
  }

  void throwEmptyDataMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.Empty, message: msg)),
    );
  }

  void emitLoading() {
    emit(AppState.loading);
  }

  void emitData(dynamic data) {
    emit(AppState.success(data));
  }
}
