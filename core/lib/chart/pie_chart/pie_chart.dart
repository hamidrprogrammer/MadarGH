import 'package:flutter/material.dart';
import 'package:core/chart/common/common_paint_utils.dart';
import 'package:core/chart/pie_chart/pie_chart_painter.dart';

import 'pie_chart_legend_icon_painter.dart';
import 'utils/legend_icon_shape.dart';
import 'utils/legend_position.dart';
import 'utils/separated_value.dart';

/// A chart type which plots the values in the form of a pie with different slices representing
/// different values. It takes the `@required` [values] parameter which provides the data to plot
/// the graph.
///
/// The other parameters are optional which define different behaviors for the chart like:
///
/// [labels] which will be shown in the graph, if not provided, will default to the value
/// of data points. If provided, it's length should be same as that of values
///
/// [size] which defines the canvas area defaults to [Size.infinite] and is constrained by
/// the parent widget.
///
/// [sliceFillColors] defines the background color of each slice of the graph, if not provided,
/// random colors will be generated.
///
/// [maxHeight] and [maxWidth] defines the maximum width and height of the chart when
/// no parent constraints are applied, otherwise ignored.
///
/// [labelColor] defines the color of the chart values, defaults to [Colors.black].
///
/// [legendTextColor] defines the color of the chart legend text, defaults to [Colors.black].
///
/// [legendPosition] defines the position of the chart legend in the layout. It can either be
/// [LegendPosition.Left], [LegendPosition.Top], [LegendPosition.Right] or [LegendPosition.Bottom].
/// The default position is [LegendPosition.Right].
///
/// [legendIconSize] defines the size of the legend icons. The default size value is `10.0`
///
/// [legendTextSize] defines the the text size of the legend labels. The default text size is `16.0`
///
/// [legendItemPadding] defines the padding around and in between the legend row items. The default
/// padding is `8.0`
///
/// [legendIconShape] defines the shape of the legend icons. It can either be [LegendIconShape.Circle]
/// or [LegendIconShape.Square]. The default shape is [LegendIconShape.Square].
///
/// [textScaleFactor] defines the factor by which the label's textSize increases with
/// respect to the average of width and height of the enclosing parent widget,
/// if not provided defaults to `0.04`
///
/// [animate] defines the animation toggle, if true, the chart will animate, else not.
/// Defaults to `true`.
///
/// [animationDuration] defines the duration (in milliseconds) of the animation for the graph. If not provided,
/// defaults to `1500 milliseconds`.
///
/// [curve] defines the animation's progress in a non-linear fashion.
///
/// [separateFocusedValue] defines whether we want to highlight focused value (of type: [SeparatedValue.Max]
/// or [SeparatedValue.Min]) as a slice separated from the chart. By default, it is set to `false`.
///
/// [separatedValueType] defines which value slice to show as separated. It can be either [SeparatedValue.Max]
/// or [SeparatedValue.Min]. The default value is [SeparatedValue.Max]
///
/// [startAngle] defines the start angle (in degrees) of the chart's radial position. The default value is `180`.
///
/// [showLegend] defines whether to show the chart legend or not. By default, it is set to `true`.
class PieChart extends StatefulWidget {
  /// Data points of the graph
  final List<double> values;

  /// Provides naming for the data points
  ///
  /// If not provided, it will default to the value of data points.
  /// If provided, it's length should be same as that of values
  final List<String>? labels;

  /// Defines the size of the canvas
  ///
  /// The canvas area defaults to [Size.infinite] and is constrained by
  /// the parent widget.
  final Size size;

  /// Defines the background color of each slice of the chart
  ///
  /// If not provided, it generates random colors for each slice.
  /// If provided, it should be of same size as `values`
  final List<Color>? sliceFillColors;

  /// Defines the maximum width of the chart
  ///
  /// If parent constraints are applied, it is ignored
  final double maxWidth;

  /// Defines the maximum height of the chart
  ///
  /// If parent constraints are applied, it is ignored
  final double maxHeight;

  /// Defines the color of the chart labels
  ///
  /// Defaults to [Colors.black]
  final Color labelColor;

  /// Defines the color of the chart legend text
  ///
  /// Defaults to [Colors.black]
  final Color legendTextColor;

  /// The position of the chart legend in the layout
  ///
  /// It can either be [LegendPosition.Left], [LegendPosition.Top],
  /// [LegendPosition.Right] or [LegendPosition.Bottom].
  /// The default position is [LegendPosition.Right].
  final LegendPosition legendPosition;

  /// Defines the size of the legend icons
  ///
  /// The default size value is `10.0`
  final double legendIconSize;

  /// Defines the the text size of the legend labels
  ///
  /// The default text size is `16.0`
  final double legendTextSize;

  /// The padding around and in between the legend row items
  ///
  /// The default padding is `8.0`
  final EdgeInsetsGeometry legendItemPadding;

  /// Defines the shape of the legend icons
  ///
  /// It can either be [LegendIconShape.Circle] or [LegendIconShape.Square].
  /// The default shape is [LegendIconShape.Square].
  final LegendIconShape legendIconShape;

  /// Percent factor of text size wrt to Height and Width
  ///
  /// the factor by which the label's textSize increases with
  /// respect to the average of width and height of the enclosing parent widget,
  /// if not provided defaults to `0.04`.
  final double textScaleFactor;

  /// It is the animation toggle
  ///
  /// If true, the chart will animate, else not. It is `true` by default.
  final bool animate;

  /// Defines the duration of the animation for the graph.
  ///
  /// If not provided, defaults to `1500 milliseconds`.
  final Duration animationDuration;

  /// It defines the animation style
  ///
  /// The default value is `Curves.easeIn`
  final Curve curve;

  /// Highlights the max or min focused value as separated slice from chart.
  ///
  /// Defines whether we want to highlight focused value (of type: [SeparatedValue.Max]
  /// or [SeparatedValue.Min]) as a slice separated from the chart. By default, it is set to `false`.
  final bool separateFocusedValue;

  /// Defines which value to show as separated slice
  ///
  /// It can be either [SeparatedValue.Max] or [SeparatedValue.Min].
  /// The default value is [SeparatedValue.Max]
  final SeparatedValue separatedValueType;

  /// Defines the start angle (in degrees) of the chart's radial position
  ///
  /// The default value is `180`.
  final double startAngle;

  /// Whether to show chart legend
  ///
  /// Defines whether to show the chart legend or not. By default, it is set to `true`.
  final bool showLegend;

  /// It plots the values as slices of pie
  ///
  /// A chart type which plots the values in the form of a pie with different slices representing
  /// different values. It takes the `required` [values] parameter which provides the data to plot
  /// the graph.
  ///
  /// The other parameters are optional which define different behaviors for the chart like `labels`,
  /// `sliceFillColors`, `labelColor` etc.
  ///
  /// Example code:
  /// ```
  /// PieChart(
  ///   values: [15, 10, 30, 25, 20],
  ///   labels: ["Label1", "Label2", "Label3", "Label4", "Label5"],
  ///   sliceFillColors: [
  ///     Colors.blueAccent,
  ///     Colors.greenAccent,
  ///     Colors.pink,
  ///     Colors.orange,
  ///     Colors.red,
  ///   ],
  ///   animationDuration: Duration(milliseconds: 1500),
  ///   legendPosition: LegendPosition.Right,
  /// )
  /// ```
  const PieChart(
      {Key? key,
      required this.values,
      this.labels,
      this.size = Size.infinite,
      this.sliceFillColors,
      this.maxWidth = 200,
      this.maxHeight = 200,
      this.labelColor = Colors.black,
      this.legendTextColor = Colors.black,
      this.legendPosition = LegendPosition.Right,
      this.legendIconSize = 10.0,
      this.legendTextSize = 16.0,
      this.legendItemPadding = const EdgeInsets.all(8.0),
      this.legendIconShape = LegendIconShape.Square,
      this.textScaleFactor = 0.04,
      this.animate = true,
      this.animationDuration = const Duration(milliseconds: 1500),
      this.curve = Curves.easeIn,
      this.separateFocusedValue = false,
      this.separatedValueType = SeparatedValue.Max,
      this.startAngle = 180,
      this.showLegend = true});

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
    with SingleTickerProviderStateMixin {
  List<Color>? _sliceFillColors;
  List<dynamic>? _labels;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _dataAnimationPercent = 0;
  late Animation _curvedAnimation;
  TextStyle _legendTextStyle = TextStyle(fontSize: 0);

  @override
  void initState() {
    super.initState();
    _sliceFillColors = widget.sliceFillColors == null
        ? CommonPaintUtils.getRandomColors(widget.values.length)
        : widget.sliceFillColors;
    _labels = widget.labels != null 
        ? widget.labels
        : widget.values.map((v) => "$v%").toList();
    _controller = AnimationController(
        vsync: this,
        duration: widget.animate
            ? widget.animationDuration
            : Duration(milliseconds: 1))
      ..forward();
    _curvedAnimation =
        CurvedAnimation(curve: widget.curve, parent: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.values.reduce((a, b) => a + b) > 100) {
      throw ArgumentError(
          "The sum of all values should be less than or equal to 100");
    } else if (widget.labels != null &&
        widget.values.length != widget.labels?.length) {
      throw ArgumentError("Values and Labels should have same size");
    } else if (widget.sliceFillColors != null &&
        widget.sliceFillColors?.length != widget.values.length) {
      throw ArgumentError(
          "Values, SliceColors and Labels should have same size");
    }
    if (widget.labels != oldWidget.labels) {
      _labels = widget.labels != null 
          ? widget.labels
          : widget.values.map((v) => "$v%").toList();
    }
    if (widget.animate) {
      if (oldWidget.animationDuration != widget.animationDuration) {
        _controller.duration = widget.animationDuration;
      }
      if (oldWidget.curve != widget.curve) {
        _curvedAnimation =
            CurvedAnimation(parent: _controller, curve: widget.curve);
      }
      setState(() {
        _controller
          ..reset()
          ..forward();
      });
    }
    _sliceFillColors = widget.sliceFillColors == null
        ? CommonPaintUtils.getRandomColors(widget.values.length)
        : widget.sliceFillColors;
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      child: widget.showLegend
          ? _getLayoutAsPerLegendPosition(widget.legendPosition)
          : _chartLayout(),
    );
  }

  Widget? _getLayoutAsPerLegendPosition(LegendPosition position) {
    switch (position) {
      case LegendPosition.Right:
        return Row(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: _chartLayout(),
            ),
            Flexible(
              flex: 1,
              child: _legendLayout(Axis.vertical),
            ),
          ],
        );
      case LegendPosition.Left:
        return Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: _legendLayout(Axis.vertical),
            ),
            Flexible(
              flex: 3,
              child: _chartLayout(),
            ),
          ],
        );
      case LegendPosition.Top:
        return Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: _legendLayout(Axis.horizontal),
            ),
            Flexible(
              flex: 3,
              child: _chartLayout(),
            ),
          ],
        );
      case LegendPosition.Bottom:
        return Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: _chartLayout(),
            ),
            Flexible(
              flex: 1,
              child: _legendLayout(Axis.horizontal),
            ),
          ],
        );
      default:
        return null;
    }
  }

  Widget _chartLayout() {
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(_curvedAnimation as Animation<double>)
          ..addListener(() {
            setState(() {
              _dataAnimationPercent = _animation.value;
              _legendTextStyle = TextStyle(
                  fontSize: widget.legendTextSize * _dataAnimationPercent);
            });
          });
    return CustomPaint(
      painter: PieChartPainter(
          widget.values,
          widget.labelColor,
          _sliceFillColors,
          widget.textScaleFactor,
          widget.separateFocusedValue,
          widget.separatedValueType,
          widget.startAngle,
          widget.legendPosition,
          widget.animate ? _dataAnimationPercent : 1.0),
      size: widget.size,
    );
  }

  Widget _legendLayout(Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemCount: _labels?.length,
      itemBuilder: (context, index) => Padding(
        padding: widget.legendItemPadding,
        child: Row(
          children: <Widget>[
            CustomPaint(
              painter: PieChartLegendIconPainter(
                  _sliceFillColors![index],
                  widget.legendIconSize,
                  widget.legendIconShape,
                  _dataAnimationPercent),
              size: Size(widget.legendIconSize, widget.legendIconSize),
            ),
            direction == Axis.vertical
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AnimatedDefaultTextStyle(
                        style: _legendTextStyle,
                        curve: widget.curve,
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          _labels![index],
                          style: TextStyle(color: widget.legendTextColor),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AnimatedDefaultTextStyle(
                      style: _legendTextStyle,
                      curve: widget.curve,
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        _labels![index],
                        style: TextStyle(color: widget.legendTextColor),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
