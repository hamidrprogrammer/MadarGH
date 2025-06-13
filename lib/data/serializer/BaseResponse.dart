import 'dart:convert';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

class BaseResponse {
  BaseResponse({
    this.result,
    this.errorMessages,
    this.systemErrorMessages,
    this.messages,
    this.resultFlag,
    this.resultCode,
    this.resultsList,
  });

  BaseResponse.fromJson(dynamic json) {
    resultCode = json['resultCode'];
    result = json['result'] != null ? jsonEncode(json['result']) : null;
    resultsList = json['resultsList'] != null ? jsonEncode(json['resultsList']) : null;
    errorMessages = json['errorMessages'] != null
        ? json['errorMessages'].cast<String>()
        : [];
    systemErrorMessages = json['systemErrorMessages'] != null
        ? json['systemErrorMessages'].cast<String>()
        : [];
    messages = json['messages'] != null ? json['messages'].cast<String>() : [];
    resultFlag = json['resultFlag'];
    resultCode = json['resultCode'];
  }

  dynamic result;
  dynamic resultsList;
  List<String>? errorMessages;
  List<String>? systemErrorMessages;
  List<String>? messages;
  bool? resultFlag;
  num? resultCode;
}
