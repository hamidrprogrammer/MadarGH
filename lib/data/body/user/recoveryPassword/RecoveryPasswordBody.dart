import 'package:json_annotation/json_annotation.dart';

part 'RecoveryPasswordBody.g.dart';

@JsonSerializable()
class RecoveryPasswordBody {
  final String username, password, confirmPassword, activationCode;

  const RecoveryPasswordBody({
    required this.username,
    required this.activationCode,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$RecoveryPasswordBodyToJson(this);

  RecoveryPasswordBody fromJson(Map<String, dynamic> json) =>
      _$RecoveryPasswordBodyFromJson(json);
}
