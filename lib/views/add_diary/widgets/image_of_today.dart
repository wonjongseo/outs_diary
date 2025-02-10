import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/full_Image_screen.dart';
import 'package:ours_log/views/image_picker_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageOfToday extends StatefulWidget {
  const ImageOfToday({
    super.key,
  });

  @override
  State<ImageOfToday> createState() => _ImageOfTodayState();
}

class _ImageOfTodayState extends State<ImageOfToday> {
  List<File> files = [];

  @override
  void initState() {
    requestPermisson();
    super.initState();
  }

  void requestPermisson() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      return PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColTextAndWidget(
      label:
          '${AppString.photoOfToday.tr}  ${files.isEmpty ? '' : '+${files.length}'}',
      labelWidget: GestureDetector(
        onTap: () async {
          File file = (await Get.to(() => const ImagePickerScreen()));
          if (!files.contains(file)) {
            files.add(file);
          }
          setState(() {}); // Don't Remove
        },
        child: const Icon(Icons.add),
      ),
      widget: files.isEmpty ? _addPhoto() : _photos(),
    );
  }

  CarouselSlider _photos() {
    return CarouselSlider(
      items: List.generate(
        files.length,
        (index) => GestureDetector(
          // onTap: () => Get.to(
          //   () => FullmageScreen(fileImage: files[index].path),
          // ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: RS.width10 * 25,
                width: RS.width10 * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RS.width10 * 4),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  image: DecorationImage(
                    image: FileImage(files[index]),
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
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    minimumSize: Size(30, 30),
                  ),
                  onPressed: () async {
                    files.remove(files[index]);

                    setState(() {}); // Don't Remove
                  },
                  icon: const Icon(Icons.remove),
                ),
              )
            ],
          ),
        ),
      ),
      options: CarouselOptions(
        height: RS.width10 * 25,
        aspectRatio: 1,
        viewportFraction: 1,
        enableInfiniteScroll: false,
      ),
    );
  }

  GestureDetector _addPhoto() {
    return GestureDetector(
      onTap: () async {
        files.add(await Get.to(() => const ImagePickerScreen()));
        setState(() {}); // Don't Remove
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: RS.width10 * 25,
          width: RS.width10 * 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RS.width10 * 4),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: RS.width10 * 5,
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
