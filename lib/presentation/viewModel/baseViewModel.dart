import 'baseViewModel.dart';

export 'package:core/utils/flow/MyFlow.dart';
export 'package:feature/messagingService/MessagingService.dart';
export 'package:feature/navigation/NavigationService.dart';
export 'package:feature/session/LocalSessionImpl.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:get_it/get_it.dart';
export 'package:my_ios_app/common/user/UserSessionConst.dart';
export 'package:my_ios_app/config/appData/route/AppRoute.dart';
export 'package:my_ios_app/presentation/state/NetworkExtensions.dart';
export 'package:my_ios_app/presentation/state/app_state.dart';

class BaseViewModel extends Cubit<AppState> {
  var messageService = GetIt.I.get<MessagingServiceImpl>();

  final session = GetIt.I.get<LocalSessionImpl>();

  BaseViewModel(super.initialState);

  void updateState(AppState newSate) {
    if (isClosed) {
      return;
    }
    emit.call(newSate);
  }

  void postResult(AppState appState) => updateState(appState);

  void postLoader() {
    if (isClosed) {
      return;
    }
    updateState(AppState.loading);
  }

  void postIdle({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.idle);
  }

  void updateScreen({required double time}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.fresh(time));
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void postSuccess({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.success(data));
  }

  MyFlow<AppState> get mainFlow => MyFlow(flow: (mainState) {
        postResult(mainState);
        if (mainState.isFailed) {
          messageService.showSnackBar(mainState.getErrorModel?.message ?? '');
        }
      });
}
