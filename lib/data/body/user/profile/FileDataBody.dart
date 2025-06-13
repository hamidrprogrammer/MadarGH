import 'package:json_annotation/json_annotation.dart';

part 'FileDataBody.g.dart';

@JsonSerializable(explicitToJson: true)
class FileDataBody {
  final String content, mimeType, fileName, Id;

  const FileDataBody({
    required this.content,
    required this.mimeType,
    required this.fileName,
    required this.Id,
  });

  static FileDataBody fromJson(Map<String, dynamic> json) =>
      _$FileDataBodyFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataBodyToJson(this);
}
