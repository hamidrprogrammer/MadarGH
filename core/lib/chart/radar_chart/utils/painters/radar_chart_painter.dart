import 'dart:math' show cos, min, pi, sin;

import 'package:core/chart/common/common_paint_utils.dart';
import 'package:core/chart/model/ChartModel.dart';
import 'package:core/chart/radar_chart/utils/radar_chart_draw_utils.dart';
import 'package:flutter/material.dart';

/// Custom Painter class for drawing the chart. Depends on various parameters like
/// [RadarChart.values], [RadarChart.labels], [RadarChart.maxValue], [RadarChart.fillColor],
/// [RadarChart.strokeColor], [RadarChart.legendTextColor], [RadarChart.textScaleFactor], [RadarChart.labelWidth],
/// [RadarChart.maxLinesForLabels], [RadarChart.chartRadiusFactor].
///
/// It also has [dataAnimationPercent] and [outlineAnimationPercent] which defines the
/// animation of the chart data and outlines.
class RadarChartPainter extends CustomPainter {
  final List<ChartModel> values;
  final List<String>? labels;
  final double maxValue;
  final Color fillColor;
  final Color strokeColor;
  final Color labelColor;
  final double textScaleFactor;
  final double? labelWidth;
  final int? maxLinesForLabels;
  final double dataAnimationPercent;
  final double outlineAnimationPercent;
  final double chartRadiusFactor;
  final int spaceCount;

  RadarChartPainter(
    this.values,
    this.labels,
    this.maxValue,
    this.fillColor,
    this.strokeColor,
    this.labelColor,
    this.textScaleFactor,
    this.labelWidth,
    this.maxLinesForLabels,
    this.dataAnimationPercent,
    this.outlineAnimationPercent,
    this.chartRadiusFactor,
    this.spaceCount,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2.0, size.height / 2.0);
    List<Offset> outerPoints = [];
    double angle = 0;
    for (var element in values) {
      angle = (2 * pi) / element.values.length;
      var valuePoints = <Offset>[];
      for (var i = 0; i < element.values.length; i++) {
        var radius = (element.values[i] / maxValue) *
            (min(center.dx, center.dy) * chartRadiusFactor);
        var x = dataAnimationPercent * radius * cos(angle * i - pi / 2);
        var y = dataAnimationPercent * radius * sin(angle * i - pi / 2);

        valuePoints.add(Offset(x, y) + center);
        // TextPainter(
        //     text: TextSpan(
        //       text: element.values[i].toStringAsFixed(0),
        //       style: const TextStyle(
        //         fontSize: 5, color: Colors.black, fontWeight: FontWeight.bold,),
        //     ),
        //     textDirection: TextDirection.ltr
        // )
        //   ..layout(minWidth: 50)
        //   ..paint(canvas, Offset(x, y) + center);
        canvas.drawCircle(Offset(x, y) + center, 3,
            CommonPaintUtils.getStrokePaint(Colors.white, 200, 1));
        canvas.drawCircle(Offset(x, y) + center, 3,
            CommonPaintUtils.getFillPaint(element.color, alpha: 100));
        // RadarChartDrawUtils.drawLabels(
        //     canvas,
        //     center,
        //     valuePoints.map((e) => '۱ از ۱').toList(),
        //     valuePoints,
        //     CommonPaintUtils.getTextSize(size / 1.2, textScaleFactor),
        //     labelWidth ??
        //         CommonPaintUtils.getDefaultLabelWidth(size, center, angle),
        //     maxLinesForLabels ??
        //         CommonPaintUtils.getDefaultMaxLinesForLabels(size),
        //     labelColor);
      }


      outerPoints = RadarChartDrawUtils.drawChartOutline(
          spaceCount,
          canvas,
          center,
          angle,
          strokeColor,
          maxValue,
          element.values.length,
          outlineAnimationPercent,
          (min(center.dx, center.dy) * chartRadiusFactor));
      RadarChartDrawUtils.drawGraphData(
          canvas, valuePoints, element.color, strokeColor);
    }

    RadarChartDrawUtils.drawLabels(
        canvas,
        center,
        labels ?? values.map((v) => v.toString()).toList(),
        outerPoints,
        CommonPaintUtils.getTextSize(size, textScaleFactor),
        labelWidth ??
            CommonPaintUtils.getDefaultLabelWidth(size, center, angle),
        maxLinesForLabels ?? CommonPaintUtils.getDefaultMaxLinesForLabels(size),
        labelColor);
  }

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return oldDelegate.dataAnimationPercent != dataAnimationPercent;
  }
}
