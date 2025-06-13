import 'dart:convert';

SliderContentResponse sliderContentFromJson(String str) =>
    SliderContentResponse.fromJson(json.decode(str));

class SliderContentResponse {
  SliderContentResponse({
    List<Images>? images,
    num? id,}){
    _images = images;
    _id = id;
  }

  SliderContentResponse.fromJson(dynamic json) {
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    _id = json['id'];
  }
  List<Images>? _images;
  num? _id;
  SliderContentResponse copyWith({  List<Images>? images,
    num? id,
  }) => SliderContentResponse(  images: images ?? _images,
    id: id ?? _id,
  );
  List<Images>? get images => _images;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['id'] = _id;
    return map;
  }

}








class Images {
  Images({
    dynamic users,
    dynamic workShopFiles,
    String? content,
    String? mimeType,
    String? fileName,
    String? id,}){
    _users = users;
    _workShopFiles = workShopFiles;
    _content = content;
    _mimeType = mimeType;
    _fileName = fileName;
    _id = id;
  }

  Images.fromJson(dynamic json) {
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
  Images copyWith({  dynamic users,
    dynamic workShopFiles,
    String? content,
    String? mimeType,
    String? fileName,
    String? id,
  }) => Images(  users: users ?? _users,
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