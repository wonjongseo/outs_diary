import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(fileImage)),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: Get.back,
                icon: const FaIcon(
                  FontAwesomeIcons.x,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
