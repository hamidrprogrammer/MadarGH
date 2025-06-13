import 'dart:async';

import 'package:core/utils/logger/Logger.dart';
import 'package:core/utils/timer/MyTimer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/presentation/state/formState/user/recovery_password_form_state.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/user/ConfirmCodeUseCase.dart';
import 'package:my_ios_app/useCase/user/SendCodeUseCase.dart';

class ForgetPasswordViewModel extends BaseViewModel implements OnTimerChange {
  ForgetPasswordViewModel(super.initialState) {
    myTimer.setOnChangeListener(this);
    getUserData();
  }

  final int _start = 120;
  late var myTimer = MyTimer(start: _start);
  final StreamController<int> _controller = StreamController();
  final formState = GlobalKey<FormState>();
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  Stream<int> get timerStream => _controller.stream;

  var mobileController = TextEditingController();
  var confirmCodeController = TextEditingController();

  Function(String) get onMobileChange =>
      (mobile) => mobileController.text = mobile;

  List<String> activationCode = List.filled(7, ""); // Store 4 characters

  onCodeChange(String value, int index) {
    if (value.isNotEmpty && value.length == 1) {
      // Update the specific index in the activationCode
      print(activationCode.length);

      activationCode[index] = value;

      // Combine the list into a single string
      confirmCodeController.text = value = activationCode.join();
    }
  }

  String convertToFarsiToEnglishNumbers(String input) {
    // Map Farsi numbers to English numbers
    final Map<String, String> farsiToEnglishNumbers = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    String result = '';

    // Iterate through each character of the input string
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      // If the character is a Farsi number, replace it with the corresponding English number
      if (farsiToEnglishNumbers.containsKey(char)) {
        result += farsiToEnglishNumbers[char]!;
      } else {
        result += char;
      }
    }

    return result;
  }

  Function() sendCode() => () {
        String englishText =
            convertToFarsiToEnglishNumbers(mobileController.text);

        SendCodeUseCase().invoke(
          MyFlow(flow: (appState) {
            postResult(appState);
            if (appState.isSuccess) {
              Logger.d(mobileController.text);
              RecoveryPasswordFormState formState = RecoveryPasswordFormState(
                  username: mobileController.text, activationCode: '123456');
              _navigationServiceImpl.navigateTo(
                  AppRoute.virfiyCodePassword, formState);
              myTimer.startTimer();
            }
            if (appState.isFailed) {
              messageService
                  .showSnackBar(appState.getErrorModel?.message ?? '');
            }
          }),
          data: englishText,
        );
      };
  RecoveryPasswordFormState formStateCode = RecoveryPasswordFormState();

  void confirmCode() {
    Logger.d(formStateCode.username);
    RecoveryPasswordFormState formState = RecoveryPasswordFormState(
        username: formStateCode.username,
        activationCode: confirmCodeController.text);
    Logger.d("START");

    _navigationServiceImpl.replaceTo(AppRoute.recoveryPassword, formState);
  }

  void getUserData() async {
    Logger.d("getUserData");

    var extraData = _navigationServiceImpl.getArgs();
    print(extraData.toString());
    if (extraData != null && extraData is RecoveryPasswordFormState) {
      formStateCode = extraData;
    }
  }

  void confirmCodeUseCaseCaller() {
    var data = {
      'mobile': mobileController.text,
      'confirmCode': confirmCodeController.text
    };
    ConfirmCodeUseCase().invoke(MyFlow(flow: (appState) {
      postResult(appState);
      if (appState.isSuccess) {
        //TODO navigate
        Logger.d('success');
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }), data: data);
  }

  @override
  void onchange(int value) {
    _controller.add(value);
  }

  @override
  Future<void> close() {
    myTimer.dispose();
    return super.close();
  }
}
