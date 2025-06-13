import 'package:json_annotation/json_annotation.dart';

part 'LoginBody.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LoginBody {
  LoginBody({
    required this.username,
    required this.password,
  });

  LoginBody fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  String username;
  final String password;
}
