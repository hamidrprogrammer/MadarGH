import 'dart:async';

class MyTimer {
  MyTimer({required this.start});

  Timer? _timer;
  int start;
  OnTimerChange? flow;

  void setOnChangeListener(OnTimerChange flow) {
    this.flow = flow;
  }


  void dispose() {
    _timer?.cancel();
  }

  Timer? get getTimer => _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          pushUpdate();
          timer.cancel();
        } else {
          pushUpdate();
          start--;
        }
      },
    );
  }

  String? get getTime => formatMMSS(start);

  void resetTimer(int time) {
    start = time;
    startTimer();
  }

  void pushUpdate() {
    flow?.onchange(start);
  }

  String? formatTime(){
    return formatMMSS(start);
  }
}

abstract class OnTimerChange {
  void onchange(int value);
}

String? formatMMSS(int time) {
  var seconds = time;
  if (time == 0) {
    return null;
  }
  final hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  final minutes = (seconds / 60).truncate();

  final minutesStr = (minutes).toString().padLeft(2, '0');
  final secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return '$minutesStr:$secondsStr';
  }

  return '$minutesStr:$secondsStr';
}
