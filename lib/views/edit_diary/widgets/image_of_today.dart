import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class ImageOfToday extends StatelessWidget {
  const ImageOfToday(
      {super.key,
      required this.uploadFiles,
      required this.label,
      required this.selectedPhotos,
      required this.removePhoto,
      required this.carouselSliderController});

  final List<File> uploadFiles;
  final Function()? selectedPhotos;
  final Function(int) removePhoto;
  final String label;
  final CarouselSliderController carouselSliderController;
  @override
  Widget build(BuildContext context) {
    return ColTextAndWidget(
      label: '$label  ${uploadFiles.isEmpty ? '' : '+${uploadFiles.length}'}',
      labelWidget: uploadFiles.length == 3
          ? null
          : GestureDetector(
              onTap: selectedPhotos,
              child: const Icon(Icons.add),
            ),
      widget: uploadFiles.isEmpty ? _addPhoto() : _photos(),
    );
  }

  CarouselSlider _photos() {
    return CarouselSlider(
      carouselController: carouselSliderController,
      items: List.generate(
        uploadFiles.length,
        (index) => GestureDetector(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: RS.w10 * 25,
                width: RS.w10 * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RS.w10 * 4),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  image: DecorationImage(
                    image: FileImage(uploadFiles[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size(30, 30),
                  ),
                  onPressed: () => removePhoto(index),
                  icon: const Icon(Icons.remove),
                ),
              )
            ],
          ),
        ),
      ),
      options: CarouselOptions(
        height: RS.w10 * 25,
        aspectRatio: 1,
        viewportFraction: 1,
        enableInfiniteScroll: false,
      ),
    );
  }

  GestureDetector _addPhoto() {
    return GestureDetector(
      onTap: selectedPhotos,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: RS.w10 * 25,
          width: RS.w10 * 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RS.w10 * 4),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: RS.w10 * 5,
                color: Colors.grey,
              ),
              Text(AppString.addPhoto.tr)
            ],
          ),
        ),
      ),
    );
  }
}
