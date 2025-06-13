import 'dart:typed_data';

import 'package:core/dioNetwork/kanoonHttp/KanoonHttp.dart';
import 'package:my_ios_app/config/apiRoute/file/FileUrls.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class DownloadFileUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is String);

    try {
      // var uri =
      // createUri(path: FileUrls.downloadFile, body: {'fileDataId': 'f27ecfb8-cce7-4da3-949d-3baafea28ea0'});
      // var header = {'Authorization' : await GetIt.I.get<LocalSessionImpl>().getData(UserSessionConst.token)};
      // print(header);
      // _launchUrl(uri, header);
      // return;

      flow.emitLoading();

      var uri =
          createUri(path: FileUrls.downloadFile, body: {'fileDataId': data});
      var response =
          await apiServiceImpl.get(uri, options: KanoonDio.fileOptions);

      if (response.isSuccessful) {
        flow.emitData(response.data);
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}

// Future<void> _launchUrl(Uri uri, Map<String, String> header) async {
//   if (!await launchUrl(uri,
//       mode: LaunchMode.externalApplication,
//       webViewConfiguration: WebViewConfiguration(headers: header))) {
//     throw Exception('Could not launch $uri');
//   }
// }
