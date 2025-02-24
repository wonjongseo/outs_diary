import 'dart:io';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ours_log/common/enums/before_alram_time.dart';

import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/datas/check_before_alarm.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/services/notification_service.dart';

class EditHosipitalVisitController extends GetxController {
  UserController userController = Get.find<UserController>();

  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  HospitalLogController hospitalLogController =
      Get.find<HospitalLogController>();

  ScrollController scrollController = ScrollController();

  NotificationService notificationService = NotificationService();

  late TextEditingController hospitalNameCtl;
  late TextEditingController officeNameCtl;
  late TextEditingController diseaseNameCtl;
  late TextEditingController diagnosisCtl;
  late List<TextEditingController> pillCtls = [];

  PersistentBottomSheetController? bottomSheetController;

  List<File> uploadFiles = [];
  List savedHospitalNames = [];
  List savedOfficeNames = [];
  List savedDiseaseNames = [];
  List savedPillNames = [];

  String? startTime;
  String? selectedBeforeAlram;
  DateTime selectedDate;

  bool isEnrollAlarm = false;

  void deleteSavedStringList(List stringList, int index) {
    stringList.removeAt(index);
    update();
  }

  List<CheckBeforeAlram> beforeAlarmTypes = List.generate(
      BeforeAlarmTimeType.values.length,
      (i) => CheckBeforeAlram(
          beforeAlarmType: BeforeAlarmTimeType.values[i], isChecked: false));

  List<CheckBeforeAlram>? savedBeforeAlarmTypes;

  final HospitalLogModel? hospitalLogModel;

  EditHosipitalVisitController({
    required this.selectedDate,
    this.hospitalLogModel,
  });

  void selectAlram(BuildContext context, int index) async {
    if (beforeAlarmTypes[index].beforeAlarmType == BeforeAlarmTimeType.any) {
      await onTapBeforeAlramTime(context);
    }
    beforeAlarmTypes[index].isChecked = !beforeAlarmTypes[index].isChecked;

    update();
  }

  String getAlramText(int index) {
    if (beforeAlarmTypes[index].beforeAlarmType == BeforeAlarmTimeType.any) {
      if (selectedBeforeAlram == null) {
        return AppString.selectText.tr;
      } else {
        return '${selectedBeforeAlram!}${AppString.before.tr}';
      }
    } else {
      return beforeAlarmTypes[index].beforeAlarmType.label!;
    }
  }

  Future<void> onTapBeforeAlramTime(BuildContext context) async {
    if (selectedBeforeAlram != null) {
      selectedBeforeAlram = null;
    } else {
      TimeOfDay? pickedTime = await showTimePicker(
        cancelText: AppString.cancelBtnTextTr.tr,
        helpText: AppString.whatTimeBeforeScrhdule.tr,
        errorInvalidText: AppString.plzInputCollectTime.tr,
        hourLabelText: AppString.hour.tr,
        minuteLabelText: AppString.minute.tr,
        context: context,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        initialTime: const TimeOfDay(hour: 0, minute: 30),
      );
      if (pickedTime == null) {
        return;
      }
      String formatedTime = pickedTime.format(context);
      selectedBeforeAlram = formatedTime;
    }
  }

  late DateTime visitDateTime;
  @override
  void onInit() {
    if (hospitalLogModel != null) {
      startTime = hospitalLogModel!.startTime;

      List<NotificationModel>? notifications = hospitalLogModel!.notifications;

      if (notifications != null && notifications.isNotEmpty) {
        int hour = int.tryParse(startTime!.split(':')[0]) ?? 0;
        int minute = int.tryParse(startTime!.split(':')[1]) ?? 0;

        this.notifications = notifications;

        isEnrollAlarm = true;
        visitDateTime = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, hour, minute);

        for (NotificationModel notificationl in notifications) {
          Duration diff = visitDateTime.difference(notificationl.notiDateTime);

          if (diff.inDays == 1) {
            beforeAlarmTypes[BeforeAlarmTimeType.oneDay.index].isChecked = true;
          } else if (diff.inHours == 6) {
            beforeAlarmTypes[BeforeAlarmTimeType.sixHour.index].isChecked =
                true;
          } else if (diff.inHours == 1) {
            beforeAlarmTypes[BeforeAlarmTimeType.oneHour.index].isChecked =
                true;
          } else {
            beforeAlarmTypes[BeforeAlarmTimeType.any.index].isChecked = true;
            selectedBeforeAlram = '$hour:$minute';
          }
        }
        savedBeforeAlarmTypes = beforeAlarmTypes;
      }

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

    savedOfficeNames =
        await SettingRepository.getList(AppConstant.officeNamesBox);
    savedDiseaseNames =
        await SettingRepository.getList(AppConstant.diseaseNamesBox);
    savedPillNames = await SettingRepository.getList(AppConstant.pillNamesBox);

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
    }
    File file = File(image!.path);

    if (!uploadFiles.contains(file)) {
      uploadFiles.add(file);
    }
    update();
  }

  void onTapVisitTime(BuildContext context) async {
    TimeOfDay? pickedTime = await AppFunction.pickTime(context);

    if (pickedTime == null) {
      return;
    }
    String formatedTime = pickedTime.format(context);
    startTime = formatedTime;
    update();
  }

  Future<void> setAlram(
      DateTime scheduledDate, String hospitalName, int hour, int minute) async {
    for (var beforeAlarmType in beforeAlarmTypes) {
      if (beforeAlarmType.isChecked) {
        DateTime? subScheduledDate;
        if (beforeAlarmType.beforeAlarmType == BeforeAlarmTimeType.any) {
          if (selectedBeforeAlram != '6:00' && selectedBeforeAlram != '01:00') {
            int? hhour = int.tryParse(selectedBeforeAlram!.split(':')[0]);
            int? mminute = int.tryParse(selectedBeforeAlram!.split(':')[1]);
            if (hhour == null && mminute == null) {
              break;
            }
            subScheduledDate = scheduledDate
                .subtract(Duration(hours: hhour!, minutes: mminute!));
          }
        } else {
          subScheduledDate = scheduledDate
              .subtract(Duration(hours: beforeAlarmType.beforeAlarmType.hour));
        }
        if (subScheduledDate != null) {
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

      // // 이미 저장된 알람
      // if (savedBeforeAlarmTypes != null) {
      //   // prettier-ignore  // 저장을 해제한 알람
      //   if (savedBeforeAlarmTypes!.contains(beforeAlarmType) &&
      //       !beforeAlarmType.isChecked) {
      //     // 삭제.

      //     DateTime diff = DateTime(
      //         visitDateTime.year,
      //         visitDateTime.month,
      //         visitDateTime.day,
      //         visitDateTime.hour - beforeAlarmType.beforeAlarmType.hour,
      //         visitDateTime.minute);

      //     hospitalLogModel!.notifications!
      //         .removeWhere((NotificationModel element) {
      //       if (element.notiDateTime == diff) {
      //         if (hospitalLogModel!.notifications!.contains(element)) {
      //           notificationService.cancellNotifications(element.alermId);
      //           return true;
      //         }
      //       }
      //       return false;
      //     });
      //   }
      // }
    }
  }

  bool validate() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      return false;
    }
    if (isEnrollAlarm && startTime == null) {
      AppSnackbar.invaildTextFeildSnackBar(
          message: AppString.plzSelectVisitTme.tr);
      AppFunction.scrollGoToTop(scrollController);
      return false;
    }
    if (hospitalNameCtl.text.isEmpty) {
      AppSnackbar.invaildTextFeildSnackBar(
          message: AppString.plzInputHospitalName.tr);
      AppFunction.scrollGoToTop(scrollController);
      return false;
    }
    return true;
  }

  void saveVisitLog() async {
    if (!validate()) return;

    String hospitalName = hospitalNameCtl.text;
    if (hospitalLogModel != null) {
      // 수정, 알람 제거
      await userController
          .deleteTaskFromNotificationList(hospitalLogModel!.notifications);
    }
    int hour = 0;
    int minute = 0;

    if (startTime != null) {
      hour = int.tryParse(startTime!.split(':')[0]) ?? 0;
      minute = int.tryParse(startTime!.split(':')[1]) ?? 0;
    }

    DateTime scheduledDate = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, hour, minute);

    if (isEnrollAlarm && startTime != null) {
      await setAlram(scheduledDate, hospitalName, hour, minute);
    }

    userController.addTask(
      TaskModel(
          taskName: '$hospitalName ${AppString.visit.tr}',
          taskDate: scheduledDate,
          notifications: notifications),
    );

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
      notifications: notifications,
    );

    if (hospitalLogModel != null) {
      newHospitalLogModel.id = hospitalLogModel!.id;
      newHospitalLogModel.createdAt = hospitalLogModel!.createdAt;
    }

    hospitalLogController.save(newHospitalLogModel);
    Get.back();

    AppSnackbar.vaildTextFeildSnackBar(
        message: hospitalLogModel == null
            ? AppString.savedVisitLog.tr
            : AppString.editedVisitLog.tr);
  }

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

    notifications
        .add(NotificationModel(notiDateTime: scheduledDate, alermId: id));
  }
}
