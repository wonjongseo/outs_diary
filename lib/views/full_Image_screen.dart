import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class FullmageScreen extends StatelessWidget {
  const FullmageScreen({super.key, required this.fileImage});

  final String fileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < -500) {
            Get.back();
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: Platform.isAndroid
                    ? EdgeInsets.only(top: RS.h10 * 5)
                    : null,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(fileImage)),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: Get.back,
                icon: FaIcon(
                  FontAwesomeIcons.x,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
