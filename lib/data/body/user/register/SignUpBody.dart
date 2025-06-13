import 'package:json_annotation/json_annotation.dart';

part 'SignUpBody.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SignUpBody {
  final firstName, lastName, email, password, confirmPassword;
  final String? mobile, ReCaptchaToken;

  SignUpBody({
    required this.firstName,
    required this.lastName,
    this.mobile,
    this.ReCaptchaToken,
    required this.password,
    required this.confirmPassword,
    required this.email,
  });

  SignUpBody fromJson(Map<String, dynamic> json) => _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);

// "isSuccess": true,
// "statusMessage": "string",
}
