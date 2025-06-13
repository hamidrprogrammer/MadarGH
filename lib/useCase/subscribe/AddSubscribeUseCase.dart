import 'package:my_ios_app/config/apiRoute/subscribe/SubscribeUrls.dart';
import 'package:my_ios_app/data/body/subscribe/AddSubscribeBody.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

UserSubscribeUseResponse userSubscribeUseResponseFromJson(String str) =>
    UserSubscribeUseResponse.fromJson(json.decode(str));

String userSubscribeUseResponseToJson(UserSubscribeUseResponse data) =>
    json.encode(data.toJson());

class UserSubscribeUseResponse {
  UserSubscribeUseResponse({
    this.id,
  });

  UserSubscribeUseResponse.fromJson(dynamic json) {
    id = json['id'];
  }

  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;

    return map;
  }
}

class AddSubscribeUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is AddSubscribeBody);

    try {
      flow.emitLoading();

      var uri = createUri(path: SubscribeUrls.addSubscribe);

      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));

      if (response.isSuccessful) {
        var result = response.result;

        if (result.isSuccessFull) {
          flow.emitData(userSubscribeUseResponseFromJson(result.result));
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
