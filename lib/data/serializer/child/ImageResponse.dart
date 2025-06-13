import 'dart:convert';
ImageResponse imageResponseFromJson(String str) => ImageResponse.fromJson(json.decode(str));
String imageResponseToJson(ImageResponse data) => json.encode(data.toJson());
class ImageResponse {
  ImageResponse({
      this.content, 
      this.mimeType, 
      this.fileName,});

  ImageResponse.fromJson(dynamic json) {
    content = json['content'];
    mimeType = json['mimeType'];
    fileName = json['fileName'];
  }
  String? content;
  String? mimeType;
  String? fileName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    map['mimeType'] = mimeType;
    map['fileName'] = fileName;
    return map;
  }

}