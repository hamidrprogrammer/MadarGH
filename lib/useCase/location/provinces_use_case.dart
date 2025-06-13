import 'package:my_ios_app/config/apiRoute/location/location_urls.dart';
import 'package:my_ios_app/data/serializer/location/ProvinceItem.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class ProvinceUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    var uri = createUri(path: LocationUrls.getAllProvinces);
    try {
      flow.emitLoading();
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(provinceItemsFromJson(result.result));
        } else {
          flow.throwMessage(result.concatErrorMessages);
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      flow.throwCatch(e);
    }
  }
}
