// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:typed_data'; // or package:universal_html/prefer_universal/html.dart

saveFile(Uint8List bytes) async{
  WebFileSaver.saveFile(bytes);
}

class WebFileSaver {
  static void saveFile(Uint8List bytes) {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${DateTime.now().microsecondsSinceEpoch}.pdf';
    html.document.body?.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
