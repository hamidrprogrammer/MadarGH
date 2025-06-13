import 'package:json_annotation/json_annotation.dart';

part 'ContactUsBody.g.dart';
@JsonSerializable(explicitToJson: true)
class ContactUsBody {
  final String  message ;
  final int contentCategoryId ;
  const ContactUsBody({

    required this.message,
    required this.contentCategoryId,
  });

  ContactUsBody fromJson(Map<String, dynamic> json) =>
      _$ContactUsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsBodyToJson(this);
}
