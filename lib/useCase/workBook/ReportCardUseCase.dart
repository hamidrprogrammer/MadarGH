import 'package:get/get.dart';
import 'package:my_ios_app/config/apiRoute/workBook/WorkBookUrls.dart';
import 'package:my_ios_app/data/serializer/workBook/WorkBookDetailResponse.dart';
import 'package:my_ios_app/presentation/uiModel/workBook/WorkBookParamsModel.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class ReportCardUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is WorkBookParamsModel);

    try {
      flow.emitLoading();
      var uri = createUri(
          path: WorkBookUrls.reportCard,
          body: (data as WorkBookParamsModel).toJson());

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

class AccordiondUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    // assert(data != null && data is WorkBookParamsModel);
    assert(data != null && data is String);
    try {
      flow.emitLoading();
      var uri = createUri(
          path: WorkBookUrls.getSolutionsOfAssessmentQuestion,
          body: {"assessmentQuestionId": data});

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.data['resultsList'];
        print(result.toString());

        flow.emitData(fluttrActivitiesFromJson(result));
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}
