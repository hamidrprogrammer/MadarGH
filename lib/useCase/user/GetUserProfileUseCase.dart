import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/data/serializer/user/GetUserProfileResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

import '../../data/body/user/information/InformationBodey.dart';

class GetUserProfileUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      var uri = createUri(path: UserUrls.getUserProfile);
      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(getUserProfileResponseFromJson(result.result));
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
  void invokeInfoUpdate(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      var uri = createUri(path: UserUrls.information);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 406) {
          flow.emitData(jsonDecode(result.result)['id'].toString());
        } else {
          if (result.isSuccessFull) {
            flow.emitData(jsonDecode(result.result)['id'].toString());
          } else {
            flow.throwMessage(result.concatErrorMessages);
          }
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
  void invokeInfoUser(MyFlow<AppState> flow) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: UserUrls.getUserInfo);
      var response = await apiServiceImpl.get(uri);
      print("invokeInfoUserss");
      if (response.isSuccessful) {
        var result = response.result;
        print(result.toString());
        print(result.isSuccessFull);
        flow.emitData(result.result);
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}
