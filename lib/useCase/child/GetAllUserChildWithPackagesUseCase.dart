import 'package:my_ios_app/config/apiRoute/child/ChildUrls.dart';
import 'package:my_ios_app/data/serializer/child/GetAllUserChilPackageResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetAllUserChildWithPackages extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      var uri = createUri(path: ChildUrls.getAllUserChildWithPackages);

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(childPackageFromJson(result.resultsList));
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
