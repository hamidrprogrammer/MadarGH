import 'dart:io';

import 'package:core/videoPlayer/android_integration.dart'
    if (dart.library.html) 'package:core/videoPlayer/web_integrationTool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({Key? key, this.data = ''}) : super(key: key);
  final String data;

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  // VideoPlayerController? videoPlayerController;
  var showController = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {

  }

  @override
  void dispose() {
    // videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.grey),
      ),
      child: 
          const CupertinoActivityIndicator()
        
    );
  }
}
