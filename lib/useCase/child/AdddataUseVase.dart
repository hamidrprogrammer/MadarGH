import 'package:my_ios_app/config/apiRoute/child/ChildUrls.dart';
import 'package:my_ios_app/data/body/child/AddChildBody.dart';
import 'package:my_ios_app/presentation/ui/user/profile/Meeting.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/BaseUseCase.dart';

class AdddataUseVase extends BaseUseCase {
  @override
  void invoke(MyFlow<AppState> flow, {Object? data}) async {
    assert(data != null && data is AddDateBody);

    try {
      flow.emitLoading();

      print(jsonEncode(data));
      var uri = createUri(path: ChildUrls.CreateEmpowermentMeeting);
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

  void getReservedMeeting(MyFlow<AppState> flow) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: ChildUrls.GetReservedMeeting);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 200) {
          print("TRUUUUUUUUU");
          flow.emitData(getUserMettingResponseFromJson(result.result));

          flow.emitData(result);
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

  void getAllSupervisorsOfUserChildren(MyFlow<AppState> flow) async {
    try {
      flow.emitLoading();

      var uri = createUri(path: ChildUrls.GetAllSupervisorsOfUserChildren);
      var response = await apiServiceImpl.get(uri);
      if (response.isSuccessful) {
        var result = response.result;
        if (result.resultCode == 200) {
          print("TRUUUUUUUUU");
          flow.emitData(getAllSupervisorsOfUserChildrenJson(result.result));

          flow.emitData(result);
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

  void cancelEmpowermentMeeting(
    MyFlow<AppState> flow,
  ) async {
    try {
      flow.emitLoading();
      var uri = createUri(path: ChildUrls.CancelEmpowermentMeeting);
      var response = await apiServiceImpl.post(uri);
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

  void ChangeEmpowermentMeetingExecutionDate(MyFlow<AppState> flow,
      {Object? data}) async {
    assert(data != null && data is AddDateBody);

    try {
      flow.emitLoading();

      print(jsonEncode(data));
      var uri =
          createUri(path: ChildUrls.ChangeEmpowermentMeetingExecutionDate);
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
