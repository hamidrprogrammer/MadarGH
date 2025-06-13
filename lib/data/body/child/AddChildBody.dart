import 'package:json_annotation/json_annotation.dart';
import 'package:my_ios_app/data/body/user/profile/FileDataBody.dart';

part 'AddChildBody.g.dart';

@JsonSerializable(explicitToJson: true)
class AddDateBody {
  AddDateBody({
    required this.executionDate,
  });

  String executionDate;

  AddDateBody fromJson(Map<String, dynamic> json) =>
      _$AddDatedBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddDateBodyToJson(this);
}

class AddChildBody {
  AddChildBody(
      {required this.childFirstName,
      required this.childLastName,
      required this.birtDate,
      required this.userName,
        required this.gender,
      this.childPicture});

  String childFirstName, childLastName, birtDate, userName;
  int gender ;
  final FileDataBody? childPicture;

  AddChildBody fromJson(Map<String, dynamic> json) =>
      _$AddChildBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddChildBodyToJson(this);
}

class EditChildBody {
  EditChildBody(
      {required this.childFirstName,
      required this.childLastName,
      required this.userChildId,
      required this.id,
        required this.gender,
      this.childPicture});

  String childFirstName, childLastName, userChildId, id;
  int gender;
  final FileDataBody? childPicture;

  EditChildBody fromJson(Map<String, dynamic> json) =>
      _$EditChildBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditChildBodyToJson(this);
}
