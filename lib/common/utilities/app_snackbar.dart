import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class AppSnackbar {
  static showNoPermissionSnackBar({required String message}) {
    AppSnackbar.showSnackBar(
      title: AppString.permission.tr,
      message: message,
      icon: Icons.warning_amber_rounded,
      color: AppColors.priPinkClr,
    );
  }

  static void vaildTextFeildSnackBar({
    String? title,
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
    String? title,
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

  static showSuccessMsgSnackBar(String message, {Duration? duration}) {
    showMessageSnackBar(
      title: AppString.completeText.tr,
      message: message,
      duration: duration,
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
      {String? title, required String message, Duration? duration}) {
    AppSnackbar.showSnackBar(
      title: title,
      message: message,
      icon: Icons.done,
      color: AppColors.primaryColor,
      duration: duration,
    );
  }

  static showSnackBar({
    String? title,
    required String message,
    required IconData icon,
    required Color color,
    Duration? duration,
  }) {
    if (Get.isSnackbarOpen) return;
    Get.rawSnackbar(
      margin: EdgeInsets.symmetric(horizontal: 10 * 1.5),
      borderRadius: 10,
      borderColor: boxWhiteOrBlack,
      backgroundColor: boxBlackOrWhite,
      titleText: title == null
          ? null
          : Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      messageText: Text(
        message,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      duration: duration ?? const Duration(milliseconds: 1500),
      snackPosition: SnackPosition.TOP,
      icon: Icon(
        icon,
        color: color,
      ),
    );
    // Get.snackbar(
    //   '',
    //   '',
    //   titleText: Text(
    //     title,
    //     style: TextStyle(
    //       color: color,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 18,
    //     ),
    //   ),
    //   messageText: Text(
    //     message,
    //     style: TextStyle(
    //       color: color,
    //       fontWeight: FontWeight.w600,
    //       fontSize: 14,
    //     ),
    //   ),
    //   duration: duration ?? const Duration(milliseconds: 1500),
    //   snackPosition: SnackPosition.TOP,
    //   backgroundColor: Colors.grey[200],
    //   colorText: color,
    //   icon: Icon(
    //     icon,
    //     color: color,
    //   ),
    // );
  }
}
