import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/blood_pressure_model.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/done_pill_day_modal.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/models/poop_condition_type.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/services/app_review_service.dart';

class EditDiaryController extends GetxController {
  final DiaryModel? diaryModel;
  final DateTime selectedDay;
  int backgroundIndex = 0, selectedFealIndex = -1;

  List<int> painFulIndex = [],
      selectedFealingIndex = [],
      selectedWeatherIndexs = [];

  List<File> uploadFiles = [];

  List<DonePillDayModel> donePillDayModels = [];

  List<PoopConditionType?> poopConditionTypes =
      List.generate(DayPeriodType.values.length, (_) => null);

  EditDiaryController({this.diaryModel, required this.selectedDay});

  void selectPoopCondition(PoopConditionType? poopCondition, int index) {
    poopConditionTypes[index] = poopCondition;
    update();
  }

  @override
  void onInit() async {
    whatToDoController = TextEditingController();

    final userModel = userController.userModel!;
    final selectedDays = userModel.selectedPillDays;
    final dayPeriodTypes = userModel.dayPeriodTypes;

    if (selectedDays?.isNotEmpty == true &&
        selectedDays!.contains(WeekDayType.values[selectedDay.weekday - 1])) {
      donePillDayModels.addAll(
        dayPeriodTypes
                ?.map((e) => DonePillDayModel(dayPeriod: e, isDone: false)) ??
            [],
      );
    }

    if (diaryModel != null) {
      loadDiaryModel();
      loadHealthModel();
      update();
    } else {
      // forText();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await setAppReviewRequest();
    super.onReady();
  }

  Future<void> setAppReviewRequest() async {
    AppReviewService.checkReviewRequest();
  }

  onTapFealIcon(int index) {
    selectedFealIndex = index;

    update();
  }

  void onToggleDonePillDayModel(int index) {
    donePillDayModels[index].isDone = !donePillDayModels[index].isDone;
    update();
  }

  void onTapSaveBtn() async {
    if (selectedFealIndex == -1) {
      AppSnackbar.vaildTextFeildSnackBar(
        title: AppString.requiredText.tr,
        message: AppString.plzSelectFeal.tr,
      );

      AppFunction.scrollGoToTop(scrollController);
      return;
    }

    String whatTodo = whatToDoController.text.trim();

    List<String> imagePhats = [];
    for (var uploadFile in uploadFiles) {
      String fileName = await ImageController.instance.saveFile(uploadFile);
      imagePhats.add(fileName);
    }

    List<PoopConditionType> poopConditions = [];

    for (var poopConditionType in poopConditionTypes) {
      if (poopConditionType != null) {
        poopConditions.add(poopConditionType);
      }
    }

    HealthModel healthModel = createHealthModel();
    DiaryModel newDiaryModel = DiaryModel(
      dateTime: selectedDay,
      fealIndex: selectedFealIndex,
      whatTodo: whatTodo,
      imagePath: imagePhats,
      donePillDayModels: donePillDayModels,
      painfulIndex: painFulIndex.isEmpty ? null : painFulIndex[0],
      health: healthModel,
      poopConditions: poopConditions,
    );

    if (diaryModel != null) {
      newDiaryModel.id = diaryModel!.id;
      newDiaryModel.createdAt = diaryModel!.createdAt;
    }

    diaryController.insert(newDiaryModel);

    AppSnackbar.vaildTextFeildSnackBar(
        title: AppString.completeText.tr,
        message:
            '${selectedDay.day}${AppString.savedHealthRecord.tr}'); //TODO EN
  }

  HealthModel createHealthModel() {
    List<double> temperatures = [];
    List<double> basicTemperatures = [];
    List<int> maxBloodPressures = [];
    List<int> minBloodPressures = [];

    List<double> weights = [];
    List<int> pulses = [];
    for (var controller in temperatureCtls) {
      temperatures.add(double.tryParse(controller.text) ?? 0.0);
    }

    for (var controller in basicTemperatureCtls) {
      basicTemperatures.add(double.tryParse(controller.text) ?? 0.0);
    }

    for (var controller in weightCtls) {
      weights.add(double.tryParse(controller.text) ?? 0.0);
    }
    for (var controller in pulseCtls) {
      pulses.add(int.tryParse(controller.text) ?? 0);
    }

    for (var controller in maxBloodPressureCtls) {
      maxBloodPressures.add(int.tryParse(controller.text) ?? 0);
    }

    for (var controller in minBloodPressureCtls) {
      minBloodPressures.add(int.tryParse(controller.text) ?? 0);
    }
    BloodPressureModel bloodPressureModel =
        BloodPressureModel(max: maxBloodPressures, min: minBloodPressures);

    HealthModel healthModel = HealthModel(
      temperatures: temperatures,
      basicTemperatures: basicTemperatures,
      bloodPressures: bloodPressureModel,
      weights: weights,
      pulses: pulses,
    );

    return healthModel;
  }

  void loadDiaryModel() {
    print('diaryModel!.poopConditions : ${diaryModel!.poopConditions}');

    if (diaryModel!.poopConditions != null) {
      poopConditionTypes = diaryModel!.poopConditions!;
    }

    if (diaryModel!.painfulIndex != null) {
      painFulIndex.add(diaryModel!.painfulIndex!);
    }
    whatToDoController.text = diaryModel!.whatTodo ?? '';
    donePillDayModels = diaryModel!.donePillDayModels ?? [];
    if (diaryModel!.imagePath != null) {
      for (var imageName in diaryModel!.imagePath!) {
        uploadFiles.add(File('${ImageController.instance.path}/$imageName'));
      }
    }

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
      if (healthModel.bloodPressures!.max != null) {
        for (var i = 0; i < healthModel.bloodPressures!.max!.length; i++) {
          if (healthModel.bloodPressures!.max![i] != 0.0) {
            maxBloodPressureCtls[i].text =
                healthModel.bloodPressures!.max![i].toString();
          }
        }
      }

      if (healthModel.bloodPressures!.min != null) {
        for (var i = 0; i < healthModel.bloodPressures!.min!.length; i++) {
          if (healthModel.bloodPressures!.min![i] != 0.0) {
            minBloodPressureCtls[i].text =
                healthModel.bloodPressures!.min![i].toString();
          }
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
    File? file = await ImageController.getImageFromLibery();
    if (file == null) return;

    if (!uploadFiles.contains(file)) {
      uploadFiles.add(file);
    }
    update();
    if (uploadFiles.length != 1) {
      carouselSliderController.nextPage();
    }
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
    for (var bloodPressureCtl in maxBloodPressureCtls) {
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
    for (var bloodPressureCtl in maxBloodPressureCtls) {
      bloodPressureCtl.dispose();
    }
    for (var bloodPressureCtl in minBloodPressureCtls) {
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

  UserController userController = Get.find<UserController>();
  ScrollController scrollController = ScrollController();
  DiaryController diaryController = Get.find<DiaryController>();

  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  late TextEditingController whatToDoController;

  List<TextEditingController> temperatureCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> basicTemperatureCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> maxBloodPressureCtls = //systolic
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> minBloodPressureCtls = //systolic
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> weightCtls =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> pulseCtls =
      List.generate(3, (index) => TextEditingController());
}
