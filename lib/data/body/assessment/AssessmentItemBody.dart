import 'package:json_annotation/json_annotation.dart';

part 'AssessmentItemBody.g.dart';

@JsonSerializable(explicitToJson: true)
class AssessmentItemBody {
  final String assessmentQuestionId, assessmentQuestionOptionId, description;

  const AssessmentItemBody(
      {required this.assessmentQuestionId,
      required this.assessmentQuestionOptionId,
      required this.description});


  AssessmentItemBody fromJson(Map<String, dynamic> json) =>
      _$AssessmentItemBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentItemBodyToJson(this);
}
