import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

class AppDialog {
  static Future<bool> jonggackDialog(
      {Widget? title, Widget? connent, Widget? action}) async {
    bool result = await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: Border.all(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              title,
              SizedBox(height: 20),
            ],
            if (connent != null) ...[
              connent,
              SizedBox(height: 20),
            ],
            // const Align(alignment: Alignment.center, child: JonggackAvator()),
            if (action != null) ...[
              SizedBox(height: 20),
              action,
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );

    return result;
  }

  static Future<bool> changeSystemLanguage() async {
    return selectionDialog(
      title: Text(
        AppString.changedSystemLanguageMsg.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(AppString.askShutDownMsg.tr),
    );
  }

  static Future<bool> errorNoEnrolledEmail() async {
    return selectionDialog(
      title: Text(
        AppString.errorCreateEmail1.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(AppString.errorCreateEmail2.tr),
    );
  }

  static Future<bool> selectionDialog({Widget? title, Widget? connent}) async {
    return jonggackDialog(
      title: title,
      connent: connent,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => Get.back(result: true),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  AppString.yesText.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => Get.back(result: false),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  AppString.noText.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JonggackAvator extends StatelessWidget {
  const JonggackAvator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10 * 15,
      height: 10 * 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            // 'assets/images/my_avator.jpeg',
            AppImagePath.circleMe,
          ),
        ),
      ),
    );
  }
}

class CustomDialog {
  // static
}
