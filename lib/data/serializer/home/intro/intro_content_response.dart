import 'dart:convert';

IntroContentResponse videoContentFromJson(String str) =>
    IntroContentResponse.fromJson(json.decode(str));

class IntroContentResponse {
  IntroContentResponse({
    Video? video,
    num? id,
  }) {
    _video = video;
    _id = id;
  }

  IntroContentResponse.fromJson(dynamic json) {
    if (json['video'] != null) {
      _video = Video.fromJson(json['video']);
    }
    _id = json['id'];
  }

  Video? _video;
  num? _id;

  IntroContentResponse copyWith({
    Video? video,
    num? id,
  }) =>
      IntroContentResponse(
        video: video ?? _video,
        id: id ?? _id,
      );

  Video? get video => _video;

  num? get id => _id;
}

class Video {
  Video({
    dynamic users,
    dynamic workShopFiles,
    String? content,
    String? mimeType,
    String? fileName,
    String? id,
  }) {
    _users = users;
    _workShopFiles = workShopFiles;
    _content = content;
    _mimeType = mimeType;
    _fileName = fileName;
    _id = id;
  }

  Video.fromJson(dynamic json) {
    _users = json['users'];
    _workShopFiles = json['workShopFiles'];
    _content = json['content'];
    _mimeType = json['mimeType'];
    _fileName = json['fileName'];
    _id = json['id'];
  }

  dynamic _users;
  dynamic _workShopFiles;
  String? _content;
  String? _mimeType;
  String? _fileName;
  String? _id;

  Video copyWith({
    dynamic users,
    dynamic workShopFiles,
    String? content,
    String? mimeType,
    String? fileName,
    String? id,
  }) =>
      Video(
        users: users ?? _users,
        workShopFiles: workShopFiles ?? _workShopFiles,
        content: content ?? _content,
        mimeType: mimeType ?? _mimeType,
        fileName: fileName ?? _fileName,
        id: id ?? _id,
      );

  dynamic get users => _users;

  dynamic get workShopFiles => _workShopFiles;

  String? get content => _content;

  String? get mimeType => _mimeType;

  String? get fileName => _fileName;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['users'] = _users;
    map['workShopFiles'] = _workShopFiles;
    map['content'] = _content;
    map['mimeType'] = _mimeType;
    map['fileName'] = _fileName;
    map['id'] = _id;
    return map;
  }
}
