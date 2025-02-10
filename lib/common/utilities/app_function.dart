// import 'dart:typed_data';
// import 'dart:io';
// import 'package:every_pet/common/theme/theme.dart';
// import 'package:every_pet/common/utilities/app_color.dart';
// import 'package:every_pet/common/utilities/app_string.dart';
// import 'package:every_pet/common/utilities/responsive.dart';
// import 'package:every_pet/common/widgets/custom_text_feild.dart';
// import 'package:every_pet/view/profile/profile_screen.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:every_pet/common/extension/custom_theme_extension.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';

// // import 'package:image/image.dart'
// class AppFunction {
//   static bool isEn() {
//     return Get.locale.toString().contains('en');
//   }

//   static bool isJp() {
//     return Get.locale.toString().contains('ja');
//   }

//   static bool isKo() {
//     return Get.locale.toString().contains('ko');
//   }

//   static String getDayYYYYMMDD(DateTime date) {
//     if (AppFunction.isEn()) {
//       return DateFormat('yyyy MMMM d').format(date);
//     }
//     return DateFormat(
//             'yyyy${AppString.yearText.tr} M${AppString.monthText.tr} d${AppString.dayText.tr}')
//         .format(date);
//   }

// // Future<void> saveImageWithQuality(File file, String savePath) async {
// //   final Image? image = Image.decodeImage(await file.readAsBytes());

// //   if (image != null) {
// //     // JPEG 품질 100으로 저장 (압축 최소화)
// //     final File output = File(savePath)
// //       ..writeAsBytesSync(img.encodeJpg(image, quality: 100));

// //     print("이미지 저장 완료: $savePath");
// //   }
// // }

//   static Future<File> uint8ListToFile(File data) async {
//     final tempDir = await getTemporaryDirectory();

//     // final filePath =
//     //     join(tempDir.path, '${DateTime.now().microsecondsSinceEpoch}.png');

//     // File file = File(filePath);
//     // if (await file.exists()) {
//     //   await file.delete();
//     // }
//     // await file.writeAsBytes(data);

//     return data;
//   }

//   // static Future<File> uint8ListToFile(Uint8List data) async {
//   //   final tempDir = await getTemporaryDirectory();

//   //   final filePath =
//   //       join(tempDir.path, '${DateTime.now().microsecondsSinceEpoch}.png');

//   //   File file = File(filePath);
//   //   if (await file.exists()) {
//   //     await file.delete();
//   //   }
//   //   await file.writeAsBytes(data);

//   //   return file;
//   // }

//   static Future<String> saveFileFromTempDirectory(
//       String tempFileImage, String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();

//     final docFile = File('${directory.path}/$fileName.png');
//     File tempFile = File(tempFileImage);
//     await tempFile.copy(docFile.path);

//     await tempFile.delete();

//     return docFile.path;
//   }

//   static void copyWord(String text) {
//     Clipboard.setData(ClipboardData(text: text));

//     if (!Get.isSnackbarOpen) {
//       Get.closeAllSnackbars();

//       String message = '「$text」${AppString.copyWordMsg.tr}';

//       showSnackBar(
//           title: 'Copy',
//           message: message,
//           icon: Icons.done,
//           color: AppColors.primaryColor);
//     }
//   }

//   static showInvalidTextFieldSnackBar({required String message}) {
//     AppFunction.showSnackBar(
//       title: AppString.requiredText.tr,
//       message: message,
//       icon: Icons.warning_amber_rounded,
//       color: pinkClr,
//     );
//   }

//   static showSuccessEnrollMsgSnackBar(String name) {
//     showMessageSnackBar(
//       title: AppString.savedText.tr,
//       message: '$name${AppString.doneAddtionMsg.tr}',
//     );
//   }

//   static showMessageSnackBar(
//       {required String title, required String message, Duration? duration}) {
//     AppFunction.showSnackBar(
//       title: title,
//       message: message,
//       icon: Icons.done,
//       color: AppColors.primaryColor,
//       duration: duration,
//     );
//   }

//   static showSnackBar({
//     required String title,
//     required String message,
//     required IconData icon,
//     required Color color,
//     Duration? duration,
//   }) {
//     if (Get.isSnackbarOpen) return;
//     Get.snackbar(
//       '',
//       '',
//       titleText: Text(
//         title,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: Responsive.width18,
//         ),
//       ),
//       messageText: Text(
//         message,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.w600,
//           fontSize: Responsive.width14,
//         ),
//       ),
//       duration: duration ?? const Duration(milliseconds: 1500),
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.grey[200],
//       colorText: color,
//       icon: Icon(
//         icon,
//         color: color,
//       ),
//     );
//   }

//   static Future<bool?> singleTextEditDialog(
//       {required String dialogName,
//       required String hintText,
//       required String buttonLabel,
//       required TextEditingController teController}) async {
//     return await Get.dialog(
//       name: dialogName,
//       AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CustomTextField(
//               autoFocus: true,
//               controller: teController,
//               hintText: hintText,
//             ),
//             SizedBox(height: Responsive.height20),
//             CustomButton(
//               height: Responsive.height10 * 4.5,
//               label: buttonLabel,
//               onTap: () => Get.back(result: true),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   static Future<bool?> multiTextEditDialog({
//     required List<String> hintTexts,
//     required String buttonLabel,
//     required List<TextEditingController> teControllers,
//     List<String>? sufficTexts,
//     List<TextInputType>? keyboardTypes,
//   }) async {
//     return await Get.dialog(
//       AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Column(
//               children: List.generate(
//                 teControllers.length,
//                 (index) => Padding(
//                   padding: EdgeInsets.only(bottom: Responsive.height10),
//                   child: CustomTextField(
//                     keyboardType:
//                         keyboardTypes == null ? null : keyboardTypes[index],
//                     autoFocus: index == 0 ? true : false,
//                     controller: teControllers[index],
//                     hintText: hintTexts[index],
//                     style: activeHintStyle,
//                     textInputAction: index == teControllers.length - 1
//                         ? TextInputAction.done
//                         : TextInputAction.next,
//                     sufficIcon:
//                         sufficTexts == null ? null : Text(sufficTexts[index]),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: Responsive.height10),
//             CustomButton(
//               height: Responsive.height10 * 4.5,
//               label: buttonLabel,
//               onTap: () => Get.back(result: true),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   static showAlertDialog({
//     required BuildContext context,
//     required String message,
//     String? btnText,
//   }) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//           content: Text(
//             message,
//             style: TextStyle(color: context.exTheme.greyColor),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text(
//                 btnText ?? "OK",
//                 style: TextStyle(
//                   color: context.exTheme.circleImageColor,
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:get/get.dart';

bool get isKo => Get.locale.toString().contains('ko');
bool get isJp => Get.locale.toString().contains('ja');
bool get isEn => Get.locale.toString().contains('en');

class AppFunction {
  static bool isEn() {
    return Get.locale.toString().contains('en');
  }

  static bool isJp() {
    return Get.locale.toString().contains('ja');
  }

  static bool isKo() {
    return Get.locale.toString().contains('ko');
  }
}
