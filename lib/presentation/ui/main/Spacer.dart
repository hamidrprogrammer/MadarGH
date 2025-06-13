import 'package:flutter/material.dart';
import 'package:my_ios_app/config/uiCommon/WidgetSize.dart';

class MySpacer extends StatelessWidget {
  const MySpacer({Key? key, this.size = WidgetSize.basePaddingSize})
      : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
