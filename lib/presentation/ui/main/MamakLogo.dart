import 'package:flutter/material.dart';

class MamakLogo extends StatelessWidget {
  const MamakLogo({Key? key, this.width = 150.0}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Image.asset(
        'assets/icon_title.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
