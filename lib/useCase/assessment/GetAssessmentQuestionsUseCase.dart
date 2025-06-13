import 'package:my_ios_app/config/apiRoute/assessment/AssessmentUrls.dart';
import 'package:my_ios_app/data/serializer/assessment/QuestionsResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetAssessmentQuestionsUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);

    try {
      flow.emitLoading();
      var uri = createUri(
          path: AssessmentUrls.getQuestions,
          body: {'userChildWorkshopId': data});

      var response = await apiServiceImpl.get(uri);

      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          var qu = questionsFromJson(result.resultsList);
          flow.emitData(qu);
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
    // TODO: implement invoke
  }
}
