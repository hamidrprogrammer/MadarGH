import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoaderBig extends StatelessWidget {
  const MyLoaderBig({
    Key? key,
    this.color = const Color.fromARGB(255, 94, 88, 88),
    this.radius = 10.0,
  }) : super(key: key);
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.hexagonDots(
      color: Color.fromARGB(255, 246, 5, 121),
      size: 45,
    ));
  }
}

class MyLoader extends StatelessWidget {
  const MyLoader({
    Key? key,
    this.color = const Color.fromARGB(255, 94, 88, 88),
    this.radius = 10.0,
  }) : super(key: key);
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.hexagonDots(
      color: Color.fromARGB(255, 255, 255, 255),
      size: 20,
    ));
  }
}
