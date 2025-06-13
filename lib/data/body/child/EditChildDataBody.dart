import 'package:json_annotation/json_annotation.dart';
import 'package:my_ios_app/data/body/user/profile/FileDataBody.dart';



part 'EditChildDataBody.g.dart';

@JsonSerializable(explicitToJson: true)
class EditChildDataBody {
  String childFirstName, childLastName, mobileNumber, childPictureId;

  final FileDataBody childPicture;

  EditChildDataBody({
    required this.childFirstName,
    required this.childLastName,
    required this.mobileNumber,
    required this.childPictureId,
    required this.childPicture,
});


  EditChildDataBody fromJson(Map<String, dynamic> json) =>
      _$EditChildDataBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditChildDataBodyToJson(this);
}