import 'package:flutter/material.dart';
class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key, required this.value}) : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value / 100,
      strokeWidth: 5,
      backgroundColor: Colors.grey.withOpacity(.5),
    );
  }
}
