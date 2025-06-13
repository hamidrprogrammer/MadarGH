import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class TextWithLink extends StatelessWidget {
  final String text;
  static final regex = RegExp("(?={)|(?<=})");

  const TextWithLink({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final split = text.split(regex);
    return RichText(
        text: TextSpan(
          children: <InlineSpan>[
            for (String text in split)
              text.startsWith('{')
                  ? TextSpan(
                text: text.substring(1, text.length - 1),
                style: const TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue,fontFamily: 'dana'),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Uri.parse(
                      'https://mamakschool.ir/home/privacy')),
              )
                  : TextSpan(text: text,style: const TextStyle(fontFamily: 'dana',color: Colors.black)),
          ],
        ));
  }

  Future<void> _launchUrl(Uri uri) async {
    // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    //   throw Exception('Could not launch $uri');
    // }
  }
}