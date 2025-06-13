import 'dart:convert';
import 'dart:html' as html;

Future<String> getVideoFromContent(String content){
  return WebIntegrationTool().getUrlFromBytes(content);
}

class WebIntegrationTool {
  Future<String> getUrlFromBytes(String bytes) =>
      Future.value(html.Url.createObjectUrlFromBlob(html.Blob([base64Decode(bytes)])));
}
