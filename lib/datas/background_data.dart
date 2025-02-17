class BackgroundData {
  final List<String> images;
  final List<double> tops;
  final List<double> rights;
  final List<double> lefts;
  final List<double> scales;
  final List<double> opacity;
  final String description;

  BackgroundData(
      {required this.images,
      required this.tops,
      required this.rights,
      required this.lefts,
      required this.scales,
      required this.opacity,
      required this.description});
}
