class GraphData {
  final List<double> xDatas;
  double? maxY;
  double? minY;

  GraphData({
    required this.xDatas,
    this.maxY,
    this.minY,
  });

  @override
  String toString() => 'GraphData(xDatas: $xDatas, maxY: $maxY, minY: $minY)';
}
