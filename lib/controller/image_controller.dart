import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

class ImageController extends GetxController {
  static late Directory directory;

  static ImageController instance = Get.find<ImageController>();

  String get path => directory.path;
  @override
  void onInit() {
    getDirectory();
    super.onInit();
  }

  static getDirectory() async {
    directory = await getLibraryDirectory();
  }

  static void requestPermisson() async {
    print('requestPermisson : ${requestPermisson}');

    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.hasAccess) {
      return;
    }
  }

  Future<String> saveFile(File file) async {
    String imageName = '${const Uuid().v4()}.png';

    final String path = '${directory.path}/$imageName';
    await file.copy(path);
    return imageName;
  }

  static Future<File?> pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      print('image : ${image}');

      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      print('e.toString : ${e.toString}');

      AppSnackbar.showNoPermissionSnackBar(
          message: AppString.noCameraPermssionMsg.tr);
    }
    return null;
  }

  static Future<File?> getImageFromLibery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } catch (e) {
      AppSnackbar.showNoPermissionSnackBar(
          message: AppString.noLibaryPermssion.tr);
    }
    return null;
  }
}
