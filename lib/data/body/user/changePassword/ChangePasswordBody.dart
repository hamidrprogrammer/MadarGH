import 'package:json_annotation/json_annotation.dart';

part 'ChangePasswordBody.g.dart';

@JsonSerializable()
class ChangePasswordBody {
  final CurrentPassword, NewPassword, ConfirmNewPassword;

  const ChangePasswordBody({
    required this.CurrentPassword,
    required this.NewPassword,
    required this.ConfirmNewPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordBodyToJson(this);

  ChangePasswordBody fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordBodyFromJson(json);
}
