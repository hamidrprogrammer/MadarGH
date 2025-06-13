// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileDataBody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileDataBody _$FileDataBodyFromJson(Map<String, dynamic> json) => FileDataBody(
      content: json['content'] as String,
      mimeType: json['mimeType'] as String,
      fileName: json['fileName'] as String,
      Id: json['Id'] as String,
    );

Map<String, dynamic> _$FileDataBodyToJson(FileDataBody instance) =>
    <String, dynamic>{
      'content': instance.content,
      'mimeType': instance.mimeType,
      'fileName': instance.fileName,
      'Id': instance.Id,
    };
