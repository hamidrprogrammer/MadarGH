import 'dart:ui';

class ChartModel {
  List<String>? pointerValue;
  final List<double> values;
  final Color color;
  ChartModel({required this.values,required this.color, this.pointerValue});
}