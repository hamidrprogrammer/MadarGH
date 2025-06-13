// import 'package:flutter_downloader/flutter_downloader.dart';
//
// class DownloadManager {
//   static void init() async {
//     await FlutterDownloader.initialize(
//         debug: true,
//         // optional: set to false to disable printing logs to console (default: true)
//         ignoreSsl:
//             true // option: set to false to disable working with http links (default: false)
//         );
//     FlutterDownloader.registerCallback(
//       (id, status, progress) => downloadCallback(id, status, progress),
//     );
//   }
//
//   @pragma('vm:entry-point')
//   static void downloadCallback(String id,int status, int progress) {
//     FlutterDownloader.registerCallback((id, status, progress) => downloadCallback(id, status, progress));
//   }
//
// }
