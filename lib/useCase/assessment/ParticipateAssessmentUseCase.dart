import 'package:my_ios_app/config/apiRoute/assessment/AssessmentUrls.dart';
import 'package:my_ios_app/data/body/assessment/ParticipateAssessmentBody.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class ParticipateAssessmentUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is ParticipateAssessmentBody);

    try {
      flow.emitLoading();
      var uri = createUri(
          path: AssessmentUrls.participateAssessment,
          body: (data as ParticipateAssessmentBody).getBody);

      var response =
          await apiServiceImpl.post(uri, data: jsonEncode(data.data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(result.result);
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
