class ChartDataModel {
  final int maxValue;
  final List<String> name;
  final List<List<double>> values;
  List<String>? lableData;

  ChartDataModel({
    required this.maxValue,
    required this.name,
    required this.values,
    this.lableData
  });
}
