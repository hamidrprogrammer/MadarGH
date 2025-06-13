import 'package:feature/downloader/DownloadTaskModel.dart';
import 'package:feature/downloader/DownloadTaskRepository.dart';
import 'package:feature/downloader/DownloadTaskStrategyRepository.dart';
// import 'package:url_launcher/url_launcher.dart';

void openUrlShared(DownloadTaskModel model) {
  DownloadTaskAndroidPlatform(model).run();
}

class DownloadTaskAndroidPlatform extends DownloadTaskRepository {
  DownloadTaskAndroidPlatform(super.model);

  @override
  Future<void> run() async {
    if (model.type == DownloadTaskTypes.file) {
      _launchUrl();
    }
  }


  Future<void> _launchUrl() async {
    // if (!await launchUrl(Uri.parse(model.link),
    //     mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch ${model.link}');
    // }
  }
}
