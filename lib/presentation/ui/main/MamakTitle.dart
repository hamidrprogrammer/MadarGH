import 'package:flutter/material.dart';

class MamakTitle extends StatelessWidget {
  const MamakTitle({Key? key, required this.title, this.fontSize = 30}) : super(key: key);
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
