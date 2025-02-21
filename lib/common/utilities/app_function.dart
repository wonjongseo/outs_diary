import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';

import 'package:photo_manager/photo_manager.dart';

bool get isKo => Get.locale.toString().contains('ko');
bool get isJp => Get.locale.toString().contains('ja');
bool get isEn => Get.locale.toString().contains('en');

class AppFunction {
  static bool isNextDay(DateTime now, DateTime compareDay) {
    if (now.year < compareDay.year) return true;
    if (now.year == compareDay.year && now.month < compareDay.month) {
      return true;
    }

    if (now.year == compareDay.year &&
        now.month == compareDay.month &&
        now.day < compareDay.day) {
      return true;
    }
    return false;
  }

  static void copyWord(String text) {
    Clipboard.setData(ClipboardData(text: text));

    if (!Get.isSnackbarOpen) {
      Get.closeAllSnackbars();

      String message = '「$text」${AppString.copyWordMsg.tr}';

      AppSnackbar.showSnackBar(
          title: 'Copy',
          message: message,
          icon: Icons.done,
          color: AppColors.primaryColor);
    }
  }

  static bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  static bool isSameMonth(DateTime day1, DateTime day2) {
    return day1.year == day2.year && day1.month == day2.month;
  }

  static bool isSameWeekDay(DateTime day1, DateTime day2) {
    return day1.weekday == day2.weekday;
  }

  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? firstDate}) async {
    return await showDatePicker(
      context: context,
      locale: Get.deviceLocale,
      initialDate: DateTime.now(),
      firstDate:
          firstDate ?? DateTime.now().subtract(const Duration(days: 365 * 3)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
  }

  static void scrollGoToTop(ScrollController scrollController) {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  static void scrollGoToBottom(ScrollController scrollController) {
    scrollController.animateTo(
      200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  static Future<TimeOfDay?> pickTime(BuildContext context,
      {required String helpText, required String errorInvalidText}) async {
    return await showTimePicker(
      cancelText: AppString.cancelBtnTextTr.tr,
      helpText: helpText,
      errorInvalidText: errorInvalidText,
      hourLabelText: AppString.hour.tr,
      minuteLabelText: AppString.minute.tr,
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  static int createIdByDay(int day, int hour, int minute) {
    return day * Random().nextInt(1000) +
        hour * Random().nextInt(100) +
        minute +
        Random().nextInt(10);
  }

  static void showNoPermissionSnackBar({required message}) {}

  static Future<File?> pickPhotosFromLibary() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } catch (e) {
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noLibaryPermssion.tr);
    }
    return null;
  }
}

String intDayToString(int? day) {
  switch (day) {
    case 1:
      return '월';
    case 2:
      return '화';
    case 3:
      return '수';
    case 4:
      return '목';
    case 5:
      return '금';
    case 6:
      return '토';
    case 7:
      return '일';
    default:
      return '월';
  }
}
