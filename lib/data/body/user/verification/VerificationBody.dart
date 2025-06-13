import 'package:json_annotation/json_annotation.dart';

part 'VerificationBody.g.dart';

@JsonSerializable(explicitToJson: true)
class VerificationBody {
  final String Username, activationCode;

  const VerificationBody({
    required this.Username,
    required this.activationCode,
  });

  VerificationBody fromJson(Map<String, dynamic> json) =>
      _$VerificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationBodyToJson(this);
}
