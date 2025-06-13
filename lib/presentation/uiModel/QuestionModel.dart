import 'package:my_ios_app/data/body/assessment/AssessmentItemBody.dart';
import 'package:my_ios_app/data/serializer/assessment/QuestionsResponse.dart';

class QuestionModel {
  String assessmentQuestionId, assessmentQuestionOptionId, description, qId;

  QuestionModel({
    this.assessmentQuestionId = '',
    this.assessmentQuestionOptionId = '',
    this.description = '',
    this.qId = '',
  });

  bool get isValid =>
      assessmentQuestionId != '' && assessmentQuestionOptionId != '';

  AssessmentItemBody createBody() => AssessmentItemBody(
      assessmentQuestionId: assessmentQuestionId,
      assessmentQuestionOptionId: assessmentQuestionOptionId,
      description: description);
}

class QuestionsObject {
  String title;
  List<Question>? questions;

  QuestionsObject({
    required this.title,
    required this.questions,
  });
}






