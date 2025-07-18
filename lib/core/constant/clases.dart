import 'dart:math';


class ChartSampleData {
  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;

  ChartSampleData({
    required this.x,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}
class CustomChartData {
  final String x;
  final double y;

  CustomChartData(this.x, this.y);
}

List<CustomChartData> generateDummyChartData(double changeRate) {
  List<CustomChartData> data = [];
  double base = 100;
  Random random = Random();

  for (int i = 0; i < 7; i++) {
    double change = (random.nextDouble() * 2 - 1) * (changeRate.abs() + 5);
    base += (changeRate < 0 ? -change : change);

    data.add(CustomChartData(i.toString(), base));
  }

  return data;
}
