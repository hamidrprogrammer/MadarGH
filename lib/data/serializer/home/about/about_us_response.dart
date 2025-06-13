import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

class AboutUsResponse {
  AboutUsResponse({String? content}) {
    _content = content;
  }

  AboutUsResponse.fromJson(dynamic json) {
    _content = json['content'];
  }

  String? _content;

  AboutUsResponse copyWith({
    String? content,
  }) =>
      AboutUsResponse(
        content: content ?? _content,
      );

  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = _content;
    return map;
  }
}
