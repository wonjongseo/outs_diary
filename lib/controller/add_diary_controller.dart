import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/controller/background_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/respository/monthly_repository.dart';
import 'package:ours_log/views/image_picker_screen.dart';

class AddDiaryController extends GetxController {
  int backgroundIndex = 0;
  int selectedFealIndex = -1;

  bool isMagicDay = false;

  bool? isStartedMasic;
  bool? isEndedMasic;
  DateTime? startMasicDay;
  DateTime? endMasicDay;

  void toggleMagicDay(bool isStartDay) {
    DateTime masicDate = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );

    if (isStartDay) {
      if (startMasicDay == null) {
        startMasicDay = masicDate;
        if (endMasicDay == startMasicDay) {
          AppFunction.invaildTextFeildSnackBar(
              title: '경고!', message: '생리의 시작 일과 끝 일이 동일합니다.');
        }
      } else {
        startMasicDay = null;
      }
    } else {
      if (endMasicDay == null) {
        endMasicDay = masicDate;

        if (startMasicDay == endMasicDay) {
          AppFunction.invaildTextFeildSnackBar(
              title: '경고!', message: '생리의 시작 일과 끝 일이 동일합니다.');
        }
      } else {
        endMasicDay = null;
      }
    }
    // isMagicDay = !isMagicDay;
    update();
  }

  BackgroundController backgroundController = Get.find<BackgroundController>();
  ScrollController scrollController = ScrollController();
  DiaryController diaryController = Get.find<DiaryController>();

  List<int> selectedWeatherIndexs = [];

  List<int> painFulIndex = [];
  List<int> selectedFealingIndex = [];
  List<File> uploadFiles = [];
  late TextEditingController whatToDoController;

  List<TextEditingController> temperatureCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> basicTemperatureCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> bloodPressureCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> weightCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> pulseCtls =
      List.generate(3, (index) => TextEditingController());

  final DiaryModel? diaryModel;
  final DateTime selectedDay;

  AddDiaryController({this.diaryModel, required this.selectedDay});

  @override
  void onInit() async {
    whatToDoController = TextEditingController();
    loadMagicDay();

    if (diaryModel != null) {
      loadDiaryModel();
      loadHealthModel();
      update();
    } else {
      forText();
    }
    super.onInit();
  }

  void loadMagicDay() async {
    startMasicDay =
        await MonthlyRepository.getPeroid(dateTime: selectedDay, isStart: true);

    endMasicDay = await MonthlyRepository.getPeroid(
        dateTime: selectedDay, isStart: false);

    if (startMasicDay != null && endMasicDay != null) {
      isStartedMasic = true;
      isEndedMasic = true;
      update();
    } else if (startMasicDay != null && endMasicDay == null) {
      isStartedMasic = true;
      update();
    }
  }

  onTapFealIcon(int index) {
    selectedFealIndex = index;
    update();
  }

  void onTapSaveBtn() {
    if (selectedFealIndex == -1) {
      AppFunction.vaildTextFeildSnackBar(
        title: AppString.requiredText.tr,
        message: AppString.plzSelectFeal.tr,
      );
      AppFunction.scrollGoToTop(scrollController);
      return;
    }

    String whatTodo = whatToDoController.text.trim();

    List<String> imagePhats = uploadFiles.map((e) => e.path).toList();

    HealthModel healthModel = createHealthModel();
    DiaryModel newDiaryModel = DiaryModel(
      dateTime: selectedDay,
      fealIndex: selectedFealIndex,
      whatTodo: whatTodo,
      imagePath: imagePhats,
      weatherIconIndex: selectedWeatherIndexs,
      painfulIndex: painFulIndex.isEmpty ? null : painFulIndex[0],
      health: healthModel,
    );

    if (diaryModel != null) {
      newDiaryModel.id = diaryModel!.id;
      newDiaryModel.createdAt = diaryModel!.createdAt;
    }

    diaryController.insert(newDiaryModel);
    if (startMasicDay != null) {
      MonthlyRepository.setPeroid(isStart: true, dateTime: startMasicDay!);
    }
    if (endMasicDay != null) {
      MonthlyRepository.setPeroid(isStart: false, dateTime: endMasicDay!);
    }

    AppFunction.vaildTextFeildSnackBar(
        title: '성공', message: '${selectedDay.day}일의 건강이 기록되었습니다.');
  }

  HealthModel createHealthModel() {
    List<double> temperatures = [];
    List<double> basicTemperatures = [];
    List<double> bloodPressures = [];
    List<double> weights = [];
    List<double> pulses = [];
    for (var controller in temperatureCtls) {
      temperatures.add(double.tryParse(controller.text) ?? 0.0);
    }

    for (var controller in basicTemperatureCtls) {
      basicTemperatures.add(double.tryParse(controller.text) ?? 0.0);
    }
    for (var controller in bloodPressureCtls) {
      bloodPressures.add(double.tryParse(controller.text) ?? 0.0);
    }
    for (var controller in weightCtls) {
      weights.add(double.tryParse(controller.text) ?? 0.0);
    }
    for (var controller in pulseCtls) {
      pulses.add(double.tryParse(controller.text) ?? 0.0);
    }
    HealthModel healthModel = HealthModel(
      temperatures: temperatures,
      basicTemperatures: basicTemperatures,
      bloodPressures: bloodPressures,
      weights: weights,
      pulses: pulses,
    );

    return healthModel;
  }

  void loadDiaryModel() {
    whatToDoController.text = diaryModel!.whatTodo ?? '';

    if (diaryModel!.imagePath != null) {
      for (var image in diaryModel!.imagePath!) {
        uploadFiles.add(File(image));
      }
    }

    selectedWeatherIndexs = diaryModel!.weatherIconIndex ?? [];
    selectedFealIndex = diaryModel!.fealIndex;
  }

  void loadHealthModel() {
    if (diaryModel!.health == null) {
      return;
    }

    HealthModel healthModel = diaryModel!.health!;

    if (healthModel.temperatures != null) {
      for (var i = 0; i < healthModel.temperatures!.length; i++) {
        if (healthModel.temperatures![i] != 0.0) {
          temperatureCtls[i].text = healthModel.temperatures![i].toString();
        }
      }
    }

    if (healthModel.basicTemperatures != null) {
      for (var i = 0; i < healthModel.basicTemperatures!.length; i++) {
        if (healthModel.basicTemperatures![i] != 0.0) {
          basicTemperatureCtls[i].text =
              healthModel.basicTemperatures![i].toString();
        }
      }
    }

    if (healthModel.bloodPressures != null) {
      for (var i = 0; i < healthModel.bloodPressures!.length; i++) {
        if (healthModel.bloodPressures![i] != 0.0) {
          bloodPressureCtls[i].text = healthModel.bloodPressures![i].toString();
        }
      }
    }

    if (healthModel.weights != null) {
      for (var i = 0; i < healthModel.weights!.length; i++) {
        if (healthModel.weights![i] != 0.0) {
          weightCtls[i].text = healthModel.weights![i].toString();
        }
      }
    }
    if (healthModel.pulses != null) {
      for (var i = 0; i < healthModel.pulses!.length; i++) {
        if (healthModel.pulses![i] != 0.0) {
          pulseCtls[i].text = healthModel.pulses![i].toString();
        }
      }
    }
  }

  void selectedPhotos() async {
    File file = (await Get.to(() => const ImagePickerScreen()));
    if (!uploadFiles.contains(file)) {
      uploadFiles.add(file);
    }
    update();
  }

  void removePhoto(int index) {
    uploadFiles.removeAt(index);
    update();
  }

  void forText() {
    for (var temperatureCtl in temperatureCtls) {
      temperatureCtl.text = (Random().nextInt(3) + 30).toString();
    }
    for (var basicTemperatureCtl in basicTemperatureCtls) {
      basicTemperatureCtl.text = (Random().nextInt(3) + 30).toString();
    }
    for (var bloodPressureCtl in bloodPressureCtls) {
      bloodPressureCtl.text = (Random().nextInt(3) + 30).toString();
    }
    for (var weightCtl in weightCtls) {
      weightCtl.text = (Random().nextInt(3) + 60).toString();
    }
    for (var pulseCtl in pulseCtls) {
      pulseCtl.text = (Random().nextInt(3) + 30).toString();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    whatToDoController.dispose();
    for (var temperatureCtl in temperatureCtls) {
      temperatureCtl.dispose();
    }
    for (var basicTemperatureCtl in basicTemperatureCtls) {
      basicTemperatureCtl.dispose();
    }
    for (var bloodPressureCtl in bloodPressureCtls) {
      bloodPressureCtl.dispose();
    }
    for (var weightCtl in weightCtls) {
      weightCtl.dispose();
    }
    for (var pulseCtl in pulseCtls) {
      pulseCtl.dispose();
    }
    super.onClose();
  }
}
