import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/body/user/profile/UploadUserAvatarBody.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class SetUserAvatarUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is UploadUserAvatarBody);

    try {
      (data as UploadUserAvatarBody).mobileNumber = await GetIt.I
          .get<LocalSessionImpl>()
          .getData(UserSessionConst.userName);
      flow.emitLoading();
      var uri = createUri(path: UserUrls.setUserAvatar);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData('');
        } else {
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}
