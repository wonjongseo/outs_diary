import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/blood_pressure_model.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/done_pill_day_modal.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/models/poop_condition.dart';
import 'package:ours_log/models/poop_condition_type.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/services/app_review_service.dart';

class EditDiaryController extends GetxController {
  final DiaryModel? diaryModel;
  final DateTime selectedDay;
  int backgroundIndex = 0, selectedFealIndex = -1;

  PoopConditionType? moringPoop, lunchPoop, eveningPoop;

  PoopConditionType? getDayPeriodPoopCondition(int index) {
    switch (index) {
      case 0:
        return moringPoop;
      case 1:
        return lunchPoop;
      case 2:
        return eveningPoop;
    }
    return null;
  }

  void setDayPeriodPoopCondition(int index, PoopConditionType? poopCondition) {
    switch (index) {
      case 0:
        moringPoop = moringPoop == poopCondition ? null : poopCondition;
      case 1:
        lunchPoop = lunchPoop == poopCondition ? null : poopCondition;
      case 2:
        eveningPoop = eveningPoop == poopCondition ? null : poopCondition;
    }
    update();
  }

  List<int> painFulIndex = [],
      selectedFealingIndex = [],
      selectedWeatherIndexs = [];

  List<File> uploadFiles = [];

  List<DonePillDayModel> donePillDayModels = [];

  EditDiaryController({this.diaryModel, required this.selectedDay});

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
      AppSnackbar.vaildTextFeildSnackBar(message: AppString.plzSelectFeal.tr);

      AppFunction.scrollGoToTop(scrollController);
      return;
    }

    List<PoopConditionModel> poopConditionTypes = [];
    if (moringPoop != null) {
      poopConditionTypes.add(PoopConditionModel(
          poopConditionType: moringPoop!,
          dayPeriodType: DayPeriodType.morning));
    }
    if (lunchPoop != null) {
      poopConditionTypes.add(PoopConditionModel(
          poopConditionType: lunchPoop!,
          dayPeriodType: DayPeriodType.afternoon));
    }
    if (eveningPoop != null) {
      poopConditionTypes.add(PoopConditionModel(
          poopConditionType: eveningPoop!,
          dayPeriodType: DayPeriodType.evening));
    }
    String whatTodo = whatToDoController.text.trim();

    List<String> imagePhats = [];
    for (var uploadFile in uploadFiles) {
      String fileName = await ImageController.instance.saveFile(uploadFile);
      imagePhats.add(fileName);
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
      poopConditions: poopConditionTypes,
    );

    if (diaryModel != null) {
      newDiaryModel.id = diaryModel!.id;
      newDiaryModel.createdAt = diaryModel!.createdAt;
    }

    diaryController.insert(newDiaryModel);

    AppSnackbar.vaildTextFeildSnackBar(
      message: '${selectedDay.day}${AppString.savedHealthRecord.tr}',
    );
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
    if (diaryModel!.poopConditions != null) {
      for (PoopConditionModel poop in diaryModel!.poopConditions!) {
        switch (poop.dayPeriodType) {
          case DayPeriodType.morning:
            moringPoop = poop.poopConditionType;

          case DayPeriodType.afternoon:
            lunchPoop = poop.poopConditionType;
          case DayPeriodType.evening:
            eveningPoop = poop.poopConditionType;
        }
      }
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

  void selectedPhotos({required bool isTakeAPhoto}) async {
    File? file = isTakeAPhoto
        ? await ImageController.pickImageFromCamera()
        : await ImageController.getImageFromLibery();
    if (file == null) return;

    if (!uploadFiles.contains(file)) {
      uploadFiles.add(file);
    }
    update();
    if (uploadFiles.length != 1) {
      carouselSliderController.animateToPage(uploadFiles.length - 1);
    }
    Get.back();
  }

  bool isRemoving = false;
  void removePhoto(int index) {
    if (isRemoving) return;
    isRemoving = true;
    uploadFiles.removeAt(index);

    update();
    isRemoving = false;
  }

  void forText() {
    for (var temperatureCtl in temperatureCtls) {
      temperatureCtl.text =
          ((Random().nextInt(10) * .1) + (Random().nextInt(1) + 0) + 36)
              .toString();
    }
    for (var basicTemperatureCtl in basicTemperatureCtls) {
      basicTemperatureCtl.text = (Random().nextInt(3) + 30).toString();
    }
    for (var pulseCtl in pulseCtls) {
      pulseCtl.text = ((Random().nextInt(5) + 5) + 80).toString();
    }
    for (var maxBloodPressureCtl in maxBloodPressureCtls) {
      maxBloodPressureCtl.text = ((Random().nextInt(10) + 10) + 100).toString();
    }
    for (var minBloodPressureCtl in minBloodPressureCtls) {
      minBloodPressureCtl.text = ((Random().nextInt(5) + 5) + 70).toString();
    }
    for (var weightCtl in weightCtls) {
      weightCtl.text =
          ((Random().nextInt(10) * .1) + (Random().nextInt(1) + 1) + 60)
              .toString();
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
