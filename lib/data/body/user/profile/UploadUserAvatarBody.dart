import 'package:json_annotation/json_annotation.dart';
import 'package:my_ios_app/data/body/user/profile/FileDataBody.dart';

part 'UploadUserAvatarBody.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadUserAvatarBody {
  String mobileNumber;
  FileDataBody fileData;

  UploadUserAvatarBody({
    required this.mobileNumber,
    required this.fileData,
  });

  UploadUserAvatarBody fromJson(Map<String, dynamic> json) =>
      _$UploadUserAvatarBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UploadUserAvatarBodyToJson(this);
}
