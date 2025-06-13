// ignore: undefined_prefixed_name

import 'package:universal_html/html.dart' as html;
import 'package:core/utils/logger/Logger.dart';
import 'package:flutter/material.dart';



class Recaptcha extends StatefulWidget {
  const Recaptcha({
    super.key,
    required this.onChangeToken,
  });

  final Function(String) onChangeToken;

  @override
  State<Recaptcha> createState() => _RecaptchaState();
}

class _RecaptchaState extends State<Recaptcha> {
  String createdViewId = 'map_element';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: HtmlElementView(
        viewType: createdViewId,
      ),
    );
  }

  @override
  void initState() {
    Logger.d('initializing');

   
    Logger.d('initialized');
    listenResponse();
    super.initState();
  }

  void listenResponse() {
    Logger.d('listenning');
    html.window.onMessage.listen((msg) {
      widget.onChangeToken.call(msg.data);
      Logger.d('msg is ${msg.data}');
    });
  }
}
