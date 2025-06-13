import 'dart:ui';

import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class CustomShakeConst implements ShakeConstant {
  @override
  List<int> get interval => [1];

  @override
  List<double> get opacity => const [];

  @override
  List<double> get rotate => const [
    0,
    4.5,
    -3.5,
    1.5,
    -1.5,
    5.5,
    3.5,
    -4.5,
    2.5,
    -1.5,
    2.5,
    -2.5,
    -0.5,
    7.5,
    0.5,
    6.5,
    -2.5,
    -1.5,
    -1.5,
    -5.5,
    6.5,
    0.5,
    -5.5,
    2.5,
    -2.5,
    -5.5,
    -3.5,
    -3.5,
    -4.5,
    2.5,
    -5.5,
    -4.5,
    6.5,
    0.5,
    -1.5,
    -6.5,
    -2.5,
    -5.5,
    -5.5,
    6.5,
    -6.5,
    -4.5,
    -3.5,
    1.5,
    5.5,
    -0.5,
    -1.5,
    -6.5,
    2.5,
    7.5,
    0
  ];

  @override
  List<Offset> get translate => const [];

  @override
  Duration get duration => const Duration(seconds: 4);
}
