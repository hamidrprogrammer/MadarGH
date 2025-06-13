import 'package:my_ios_app/config/apiRoute/user/UserUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

import '../../data/body/user/information/InformationBodey.dart';

class InformationUseCase extends BaseUseCase {
  Future<Map<String, dynamic>> getData() async {
    var uri = createUri(path: UserUrls.getInformation);
    var response = await apiServiceImpl.get(uri);
    if (response.statusCode == 200) {
      var result = response.result;
      print("res");
      return jsonDecode(result.result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getDataDetails() async {
    var uriInfo = createUri(path: UserUrls.getUserInfoFromToken);
    var responseInfo = await apiServiceImpl.get(uriInfo);
    if (responseInfo.statusCode == 200) {
      var resultInfo = responseInfo.result;
      var data = jsonDecode(resultInfo.result);
      var uri =
          createUri(path: UserUrls.gtUserDetails, body: {'userId': data['id']});
      var response = await apiServiceImpl.get(uri);
      var result = response.result;

      print(result.result);
      return jsonDecode(result.result);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
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
}
