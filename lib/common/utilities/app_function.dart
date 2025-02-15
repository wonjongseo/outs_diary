import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

bool get isKo => Get.locale.toString().contains('ko');
bool get isJp => Get.locale.toString().contains('ja');
bool get isEn => Get.locale.toString().contains('en');

class AppFunction {
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
}
