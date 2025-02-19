import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/controller/notification_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/respository/setting_repository.dart';

class AddHosipitalVisitController extends GetxController {
  String? startTime;

  bool isEnrollAlarm = false;
  List savedHospitalNames = [];
  UserController userController = Get.find<UserController>();

  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  HospitalLogController hospitalLogController =
      Get.find<HospitalLogController>();

  late TextEditingController hospitalNameCtl;
  late TextEditingController officeNameCtl;
  late TextEditingController diseaseNameCtl;
  late TextEditingController diagnosisCtl;

  ScrollController scrollController = ScrollController();

  late List<TextEditingController> pillCtls = [];
  List<File> uploadFiles = [];

  NotificationService notificationService = NotificationService();

  PersistentBottomSheetController? bottomSheetController;

  bool isBeforeOneHourAlarm = false;
  bool isBeforeSizHourAlarm = false;
  bool isBeforeOneDayAlarm = false;

  String? selectedBeforeAlram;
  DateTime selectedDate;
  void onTapBeforeAlramTime(BuildContext context) async {
    if (selectedBeforeAlram != null) {
      selectedBeforeAlram = null;
    } else {
      TimeOfDay? pickedTime = await showTimePicker(
        cancelText: AppString.cancelBtnTextTr.tr,
        helpText: '몇 시간 전에 알람을 받고 싶으세요?',
        errorInvalidText: '올바른 시간을 입력해주세요',
        hourLabelText: AppString.hour.tr,
        minuteLabelText: AppString.minute.tr,
        context: context,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime == null) {
        return;
      }
      String formatedTime = pickedTime.format(context);
      selectedBeforeAlram = formatedTime;
    }
    update();
  }

  final HospitalLogModel? hospitalLogModel;
  AddHosipitalVisitController({
    required this.selectedDate,
    this.hospitalLogModel,
  });
  @override
  void onInit() {
    if (hospitalLogModel != null) {
      startTime = hospitalLogModel!.startTime;
      hospitalNameCtl =
          TextEditingController(text: hospitalLogModel!.hospitalName);
      officeNameCtl = TextEditingController(text: hospitalLogModel!.officeName);
      diseaseNameCtl =
          TextEditingController(text: hospitalLogModel!.diseaseName);
      diagnosisCtl = TextEditingController(text: hospitalLogModel!.diagnosis);

      uploadFiles = hospitalLogModel!.imagesPath.map((e) => File(e)).toList();

      if (hospitalLogModel!.pills != null) {
        for (var pill in hospitalLogModel!.pills!) {
          pillCtls.add(TextEditingController(text: pill));
        }
      }
    } else {
      hospitalNameCtl = TextEditingController();
      officeNameCtl = TextEditingController();
      diseaseNameCtl = TextEditingController();
      diagnosisCtl = TextEditingController();
      pillCtls.add(TextEditingController());
    }
    super.onInit();
    getHospitalNams();
  }

  @override
  void onClose() {
    hospitalNameCtl.dispose();
    officeNameCtl.dispose();
    diseaseNameCtl.dispose();
    diagnosisCtl.dispose();
    for (var pillCtl in pillCtls) {
      pillCtl.dispose();
    }
    scrollController.dispose();
    super.onClose();
  }

  void getHospitalNams() async {
    savedHospitalNames =
        await SettingRepository.getList(AppConstant.hospitalNamesBox);
    update();
  }

  void onTapVisitDay(BuildContext context) async {
    DateTime? pickerDate = await AppFunction.pickDate(context);
    if (pickerDate != null) {
      selectedDate = pickerDate;
      update();
    }
  }

  void onTapEnrollAlarm() {
    isEnrollAlarm = !isEnrollAlarm;
    update();
  }

  void addPillCtl() {
    pillCtls.add(TextEditingController());
    update();
  }

  void removePhoto(int index) {
    uploadFiles.removeAt(index);
    update();
  }

  void addPhotos() async {
    Get.back();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    } //
    File file = File(image!.path);

    if (!uploadFiles.contains(file)) {
      uploadFiles.add(file);
    }
    update();
  }

  void onTapVisitTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      cancelText: AppString.cancelBtnTextTr.tr,
      helpText: AppString.plzInputvisitTime.tr,
      errorInvalidText: AppString.plzInputCollectTime.tr,
      hourLabelText: AppString.hour.tr,
      minuteLabelText: AppString.minute.tr,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) {
      return;
    }
    String formatedTime = pickedTime.format(context);
    startTime = formatedTime;
    update();
  }

  void saveVisitLog() async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      return;
    }
    if (isEnrollAlarm && startTime == null) {
      AppSnackbar.invaildTextFeildSnackBar(
          title: AppString.requiredText.tr,
          message: '알람을 등록하기 위해서, 방문 시간을 선택해주세요.');
      AppFunction.scrollGoToTop(scrollController);
      return;
    }
    String hospitalName = hospitalNameCtl.text;
    if (hospitalName.isEmpty) {
      AppSnackbar.invaildTextFeildSnackBar(
          title: AppString.requiredText.tr, message: '병원 이름을 입력해주세요');
      AppFunction.scrollGoToTop(scrollController);
      return;
    }

    int hour = int.parse(startTime!.split(':')[0]);
    int minute = int.parse(startTime!.split(':')[1]);

    DateTime scheduledDate = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, hour, minute);
    if (isEnrollAlarm && startTime != null) {
      if (isBeforeOneDayAlarm) {
        DateTime subScheduledDate =
            scheduledDate.subtract(const Duration(days: 1));
        enrollSchedule(
          hospitalName,
          scheduledDate.month,
          scheduledDate.day,
          hour,
          minute,
          subScheduledDate,
        );
      }
      if (isBeforeSizHourAlarm) {
        DateTime subScheduledDate =
            scheduledDate.subtract(const Duration(hours: 6));
        enrollSchedule(
          hospitalName,
          scheduledDate.month,
          scheduledDate.day,
          hour,
          minute,
          subScheduledDate,
        );
      }
      if (isBeforeOneHourAlarm) {
        DateTime subScheduledDate =
            scheduledDate.subtract(const Duration(hours: 1));
        enrollSchedule(
          hospitalName,
          scheduledDate.month,
          scheduledDate.day,
          hour,
          minute,
          subScheduledDate,
        );
      }

      if (selectedBeforeAlram != null) {
        if (selectedBeforeAlram != '6:00' && selectedBeforeAlram != '01:00') {
          int? hhour = int.tryParse(selectedBeforeAlram!.split(':')[0]);
          int? mminute = int.tryParse(selectedBeforeAlram!.split(':')[1]);

          if (hhour == null && mminute == null) {
            return;
          }

          DateTime subScheduledDate = scheduledDate
              .subtract(Duration(hours: hhour!, minutes: mminute!));

          enrollSchedule(
            hospitalName,
            scheduledDate.month,
            scheduledDate.day,
            hour,
            minute,
            subScheduledDate,
          );
        }
      }
    }
    userController.addTask(TaskModel(
        taskName: '$hospitalName 방문',
        taskDate: scheduledDate,
        notifications: notifications));

    String officeName = officeNameCtl.text;
    String diseaseName = diseaseNameCtl.text;
    String diagnosis = diagnosisCtl.text;

    List<String> pills = pillCtls.map((e) => e.text).toList();

    List<String> imagesPath = uploadFiles.map((e) => e.path).toList();

    HospitalLogModel newHospitalLogModel = HospitalLogModel(
      startTime: startTime,
      dateTime: selectedDate,
      hospitalName: hospitalName,
      officeName: officeName,
      diseaseName: diseaseName,
      diagnosis: diagnosis,
      imagesPath: imagesPath,
      pills: pills,
      notificationId: notificationId,
    );

    if (hospitalLogModel != null) {
      newHospitalLogModel.id = hospitalLogModel!.id;
      newHospitalLogModel.createdAt = hospitalLogModel!.createdAt;
    }

    hospitalLogController.save(newHospitalLogModel);
    Get.back();

    AppSnackbar.vaildTextFeildSnackBar(
      title: hospitalLogModel == null ? '저장' : '변경',
      message:
          hospitalLogModel == null ? '병원 기록이 저장 되었습니다.' : '병원 기록이 변경 되었습니다.',
    );
  }

  List<int> notificationId = [];

  List<NotificationModel> notifications = [];

  void enrollSchedule(String hospitalName, int appointMonth, int appointDay,
      int appointHour, int appointMinute, DateTime scheduledDate) {
    int id = AppFunction.createIdByDay(
        selectedDate.day, scheduledDate.hour, scheduledDate.minute);

    String message =
        '$appointMonth월 $appointDay일 $appointHour시$appointMinute분에 $hospitalName 병원 진료가 예약되어있습니다!';
    print('message : ${message}');

    notificationService.scheduleSpecificDateNotification(
      title: '🏥 병원 진료 알림',
      message: message,
      channelDescription: '병원 진료 예약 알람',
      id: id,
      year: scheduledDate.year,
      month: scheduledDate.month,
      day: scheduledDate.day,
      hour: scheduledDate.hour,
      minute: scheduledDate.minute,
    );

    notificationId.add(id);
    notifications
        .add(NotificationModel(notiDateTime: scheduledDate, alermId: id));
  }
}
