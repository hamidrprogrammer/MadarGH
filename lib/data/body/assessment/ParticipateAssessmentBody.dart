import 'AssessmentItemBody.dart';

class ParticipateAssessmentBody {
  String userChildWorkshopId;
  List<AssessmentItemBody>? data;

  ParticipateAssessmentBody({
    this.userChildWorkshopId = '',
    this.data,
  });

  Map<String, String> get getBody =>
      {'userChildWorkshopId': userChildWorkshopId};
}
