class GraphData {
  final List<double> xDatas;
  double maxY;
  double minY;

  GraphData({
    required this.xDatas,
    this.maxY = 0,
    this.minY = 0,
  });

  @override
  String toString() => 'GraphData(xDatas: $xDatas, maxY: $maxY, minY: $minY)';
}
