import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:photo_manager/photo_manager.dart';

class AppSnackbar {
  static void vaildTextFeildSnackBar({
    required String title,
    required String message,
    Duration? duration,
  }) {
    AppSnackbar.showSnackBar(
      title: title,
      message: message,
      icon: FontAwesomeIcons.check,
      color: Colors.redAccent,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void invaildTextFeildSnackBar({
    required String title,
    required String message,
    Duration? duration,
  }) {
    AppSnackbar.showSnackBar(
        title: title,
        message: message,
        icon: FontAwesomeIcons.exclamation,
        color: Colors.redAccent,
        duration: duration ?? const Duration(seconds: 3));
  }

  static showSuccessMsgSnackBar(String message) {
    showMessageSnackBar(
      title: AppString.completeText.tr,
      message: message,
    );
  }

  static showSuccessEnrollMsgSnackBar(String name) {
    showMessageSnackBar(
      title: AppString.savedText.tr,
      message: '$name${AppString.doneAddtionMsg.tr}',
    );
  }

  static showSuccessChangedMsgSnackBar(String name) {
    showMessageSnackBar(
      title: AppString.updatedText.tr,
      message: '$name${AppString.doneUpdatedMsg.tr}',
    );
  }

  static showMessageSnackBar(
      {required String title, required String message, Duration? duration}) {
    AppSnackbar.showSnackBar(
      title: title,
      message: message,
      icon: Icons.done,
      color: AppColors.primaryColor,
      duration: duration,
    );
  }

  static showSnackBar({
    required String title,
    required String message,
    required IconData icon,
    required Color color,
    Duration? duration,
  }) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: RS.width18,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: RS.width14,
        ),
      ),
      duration: duration ?? const Duration(milliseconds: 1500),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey[200],
      colorText: color,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
