import 'package:my_ios_app/config/apiRoute/child/ChildUrls.dart';
import 'package:my_ios_app/data/body/child/AddChildBody.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class AddChildUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is AddChildBody);

    try {
      flow.emitLoading();

      print(jsonEncode(data));
      var uri = createUri(path: ChildUrls.addChild);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 200) {
          print("TRUUUUUUUUU");
          flow.emitData('data');
          // flow.throwMessage(result.concatSuccessMessages);
        } else {
          print("FALSSSSSSSSSSS");

          flow.throwMessage(result.concatErrorMessages);
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

class EditChildUseCase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is EditChildBody);

    try {
      flow.emitLoading();

      print(jsonEncode(data));
      var uri = createUri(path: ChildUrls.editChild);
      var response = await apiServiceImpl.post(uri, data: jsonEncode(data));
      if (response.isSuccessful) {
        var result = response.result;
        print("${result.resultCode}");
        if (result.resultCode == 200) {
          print("object==============>");
          flow.emitData('data');
          // flow.throwMessage(result.concatSuccessMessages);
        } else {
          flow.throwMessage(result.concatErrorMessages);
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
