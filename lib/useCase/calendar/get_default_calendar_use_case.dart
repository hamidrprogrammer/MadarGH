import 'package:my_ios_app/config/apiRoute/calendar/calendar_urls.dart';
import 'package:my_ios_app/data/serializer/calendar/UserCalendarResponse.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class GetDefaultCalendarUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    try {
      flow.emitLoading();
      var uri =
          createUri(path: CalendarUrls.getDefaultCalendarForHomePageOfApp);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull) {
          flow.emitData(defaultCalendarFromJson(result.resultsList));
        } else {
          if (result.resultCode == 204) {
            flow.emitData(204);
          } else {
            flow.throwMessage(result.concatErrorMessages);
          }
        }
      } else {
        flow.throwError(response);
      }
    } catch (e) {
      Logger.e(e);
      flow.throwCatch(e);
    }
  }
}
