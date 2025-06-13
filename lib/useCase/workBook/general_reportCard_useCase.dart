import 'package:my_ios_app/config/apiRoute/workBook/WorkBookUrls.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GeneralReportCardUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is int);

    try {
      flow.emitLoading();
      var uri = createUri(path: WorkBookUrls.generalReportCard, body: {
        'userChildId': data.toString(),
      });

      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(workBookDetailResponseFromJson(result.result));
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
  void invokePcage(MyFlow<AppState> flow, {Object? data,Object? dataT}) async {
    print("dataT");
    print(dataT);
    print(data);
    // assert(data != null && data is int);

    try {
      flow.emitLoading();
      var uri = createUri(path: WorkBookUrls.generalReportCard, body: {
        'userChildId': data.toString(),
        'packageId': dataT.toString(),
      });

      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(workBookDetailResponseFromJson(result.result));
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
