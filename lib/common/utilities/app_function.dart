import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

bool get isKo => Get.locale.toString().contains('ko');
bool get isJp => Get.locale.toString().contains('ja');
bool get isEn => Get.locale.toString().contains('en');

class AppFunction {
  static bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  static bool isSameMonth(DateTime day1, DateTime day2) {
    return day1.year == day2.year && day1.month == day2.month;
  }

  static void requestPermisson() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      return PhotoManager.openSetting();
    }
  }

  static Future<DateTime?> pickDate(BuildContext context,
      {DateTime? firstDate}) async {
    return await showDatePicker(
      context: context,
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

  static void vaildTextFeildSnackBar({
    required String title,
    required String message,
  }) {
    AppFunction.showSnackBar(
        title, message, FontAwesomeIcons.check, Colors.redAccent);
  }

  static void invaildTextFeildSnackBar({
    required String title,
    required String message,
  }) {
    AppFunction.showSnackBar(
        title, message, FontAwesomeIcons.exclamation, Colors.redAccent);
  }

  static void showSnackBar(
      String title, String message, IconData iconData, Color borderColor) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        icon: Icon(iconData),
        borderWidth: 1,
        borderColor: borderColor,
      );
    }
  }

  static void showNoPermissionSnackBar({required message}) {}
}
