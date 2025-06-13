import 'dart:async';

import 'package:core/utils/timer/MyTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ios_app/data/serializer/app/ContactUsResponse.dart';
import 'package:my_ios_app/presentation/state/formState/user/RegisterFormState.dart';

import 'package:my_ios_app/presentation/state/formState/user/VerificationFormState.dart';
import 'package:my_ios_app/presentation/viewModel/baseViewModel.dart';
import 'package:my_ios_app/useCase/app/GetContactUsUseCase.dart';
import 'package:my_ios_app/useCase/user/SendVerificationCodeUseCase.dart';
import 'package:my_ios_app/useCase/user/VerificationUseCase.dart';

class VerificationViewModel extends BaseViewModel implements OnTimerChange {
  VerificationViewModel(super.initialState) {
    myTimer.setOnChangeListener(this);
    myTimer.startTimer();
    getExtra();
    getContactUsData();
  }

  AppState formUiState = AppState.idle;
  AppState activationCodeState = AppState.idle;
  AppState timerState = AppState.idle;
  String? numberData;
  String? id;
  final int _start = 120;
  late var myTimer = MyTimer(start: _start);
  final StreamController<int> _controller = StreamController();

  final formState = GlobalKey<FormState>();
  final navigationService = GetIt.I.get<NavigationServiceImpl>();

  final VerificationFormState verificationFormState = VerificationFormState();
  RegisterFormState formStater = RegisterFormState();
  List<String> activationCode = List.filled(7, ""); // Store 4 characters

  onCodeChange(String value, int index) {
    if (value.isNotEmpty && value.length == 1) {
      // Update the specific index in the activationCode
      print(activationCode.length);

      activationCode[index] = value;

      // Combine the list into a single string
      verificationFormState.activationCode = value = activationCode.join();
    }
  }

  void onSubmitCodeClick() {
    print(verificationFormState.activationCode);

    if (verificationFormState.Username.isEmpty) {
      messageService.showSnackBar('ErrorMessage_4_0_1'.tr);
      return;
    }
    // if (formState.currentState?.validate() == true) {
    VerificationUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
      if (appState.isSuccess) {
        navigationService.replaceTo(AppRoute.login);
      }
      formUiState = appState;
      refresh();
    }), data: verificationFormState.createBody());
    // }
  }

  void refresh() {
    updateScreen(time: DateTime.now().microsecondsSinceEpoch.toDouble());
  }

  void getExtra() {
    var data = navigationService.getArgs();

    if (data['email'].toString().length > 5) {
      print("data['email']");
      verificationFormState.Username = data['email'];
      id = data['id'];
    }
    if (data['mobil'].toString().length > 5) {
      print("data['mobil']");

      verificationFormState.Username = data['mobil'];
      id = data['id'];
    }
    if (data['id'] != null) {
      id = data['id'];
    }
  }

  void sendActivationCode() {
    if (id == null) return;
    SendVerificationUseCase().invoke(MyFlow(flow: (appState) {
      activationCodeState = appState;
      refresh();
      if (appState.isSuccess) {
        myTimer.startTimer();
        messageService.showSnackBar(
            "${'new_code_sent'.tr} ${verificationFormState.Username}");
      }
      if (appState.isFailed) {
        messageService.showSnackBar(appState.getErrorModel?.message ?? '');
      }
    }), data: id);
  }

  void getContactUsData() {
    GetContactUsUseCase().invoke(MyFlow(flow: (appState) {
      if (appState.isSuccess && appState.getData is ContactUsResponse) {
        ContactUsResponse data = appState.getData;
        numberData = '${'contact_us'.tr} : ${data.tellNumber}';
        refresh();
      }
    }));
  }

  Stream<int> get timerStream => _controller.stream;

  @override
  void onchange(int value) {
    _controller.add(value);
  }

  @override
  Future<void> close() {
    myTimer.dispose();
    return super.close();
  }

  void sendCode() {
    myTimer.setOnChangeListener(this);

    myTimer.startTimer();
    sendActivationCode();
  }
}
