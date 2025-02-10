class IconModel {
  final String imagePath;
  final String iconName;

  IconModel({required this.imagePath, required this.iconName});
}

class UserModel {
  List<IconModel> fealingIcons = [];
}

class DiaryModel {
  final DateTime dateTime;
  final int fealIndex;
  final List<int>? iconIndexs;
  final String? whatTodo;
  final String? imagePath;
  final HealthModel? health;

  DiaryModel({
    required this.dateTime,
    required this.fealIndex,
    this.iconIndexs,
    this.whatTodo,
    this.imagePath,
    this.health,
  });
}

class HealthModel {
  double? temperature;
  double? basicTemperature;
  double? bloodPressure;
  double? weight;
  double? pulse;

  HealthModel({
    this.temperature,
    this.basicTemperature,
    this.bloodPressure,
    this.weight,
    this.pulse,
  });
}
