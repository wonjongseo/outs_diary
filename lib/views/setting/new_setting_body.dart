import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/setting/set_background_widget.dart';

class NewSettingBody extends StatefulWidget {
  const NewSettingBody({super.key});

  @override
  State<NewSettingBody> createState() => _NewSettingBodyState();
}

class _NewSettingBodyState extends State<NewSettingBody> {
  bool isDarkMode = Get.isDarkMode;
  void changeTheme(int index) {
    if (index == 0) {
      isDarkMode = true;
      SettingRepository.setBool(AppConstant.isDarkModeKey, true);
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      SettingRepository.setBool(AppConstant.isDarkModeKey, false);
      isDarkMode = false;
      Get.changeThemeMode(ThemeMode.light);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<UserController>(builder: (userController) {
        return Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '취향에 맞게 설정',
                  style: headingstyle(),
                ),
                ListTile(
                  title: Text('감정 아이콘'),
                ),
                ListTile(
                  iconColor: AppColors.primaryColor,
                  title: Text(AppString.background.tr),
                  onTap: () => Get.to(() => const SetBackgroundScreen()),
                  subtitle: Text(AppConstant
                      .backgroundLists[
                          userController.userModel?.backgroundIndex ?? 0]
                      .description),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                _color(userController),
              ],
            ),
            SizedBox(height: RS.h10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '시스템 설정',
                  style: headingstyle(),
                ),
                ListTile(
                  title: Text('알림'),
                ),
                ListTile(
                  title: Text('언어'),
                ),
                ListTile(
                  title: Text(AppString.theme.tr),
                  subtitle: Text(isDarkMode
                      ? AppString.darkMode.tr
                      : AppString.lightMode.tr),
                  trailing: ToggleButtons(
                    borderRadius: BorderRadius.circular(RS.w10 * 1.8),
                    onPressed: changeTheme,
                    isSelected: [isDarkMode, !isDarkMode],
                    children: const [
                      Icon(Icons.dark_mode),
                      Icon(Icons.light_mode),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: RS.h10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '그 외',
                  style: headingstyle(),
                ),
                ListTile(
                  title: Text('피드백 또는 에러 제보'),
                ),
                ListTile(
                  title: Text('별점 남기러 가기'),
                ),
                ListTile(
                  title: Text('앱 버전'),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  ExpansionTileCard _color(UserController userController) {
    return ExpansionTileCard(
      elevation: 0,
      title: Text(AppString.color.tr),
      trailing: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => userController.changePrimaryColor(0),
              child: CircleAvatar(
                radius: RS.w10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priPinkClr,
                child: userController.userModel!.colorIndex == 0
                    ? Icon(Icons.done)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () => userController.changePrimaryColor(1),
              child: CircleAvatar(
                radius: RS.w10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priYellowClr,
                child: userController.userModel!.colorIndex == 1
                    ? Icon(Icons.done)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () => userController.changePrimaryColor(2),
              child: CircleAvatar(
                radius: RS.w10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priGreenClr,
                child: userController.userModel!.colorIndex == 2
                    ? Icon(Icons.done)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () => userController.changePrimaryColor(3),
              child: CircleAvatar(
                radius: RS.w10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priBluishClr,
                child: userController.userModel!.colorIndex == 3
                    ? Icon(Icons.done)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () => userController.changePrimaryColor(4),
              child: CircleAvatar(
                radius: RS.w10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priPubbleClr,
                child: userController.userModel!.colorIndex == 4
                    ? Icon(Icons.done)
                    : null,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  TextStyle headingstyle() {
    return TextStyle(
      fontSize: RS.w10 * 1.8,
      fontWeight: FontWeight.w600,
      color: textWhiteOrBlack,
    );
  }
}
