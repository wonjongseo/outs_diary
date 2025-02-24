import 'dart:developer';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app.dialog.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/setting/set_feal_icon_screen.dart';
import 'package:ours_log/views/setting/set_background_widget.dart';
import 'package:ours_log/views/setting/setting_alram_screen.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  String settingLanguage = '';
  String displayLanguage = '';
  bool isDarkMode = Get.isDarkMode;

  @override
  void initState() {
    super.initState();
    getSettingLanguage();
  }

  void getSettingLanguage() async {
    settingLanguage =
        await SettingRepository.getString(AppConstant.settingLanguageKey);

    if (settingLanguage.isEmpty) {
      settingLanguage = Get.locale.toString();
      await SettingRepository.setString(
        AppConstant.settingLanguageKey,
        settingLanguage,
      );
    }

    if (settingLanguage.contains('ko')) {
      displayLanguage = AppString.koreanText.tr;
    } else if (settingLanguage.contains('ja')) {
      displayLanguage = AppString.japaneseText.tr;
    } else {
      displayLanguage = AppString.englishText.tr;
    }

    setState(() {});
  }

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
    log("SettingBody");
    return settingLanguage.isEmpty
        ? Container()
        : GetBuilder<UserController>(builder: (userController) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: RS.height20),
                  _customListTIle(
                    title: AppString.theme.tr,
                    subTitle: isDarkMode
                        ? AppString.darkMode.tr
                        : AppString.lightMode.tr,
                    imagePath: AppImagePath.very_good2,
                    onTap: () => changeTheme(isDarkMode ? 0 : 1),
                    widget: ToggleButtons(
                      borderRadius: BorderRadius.circular(RS.w10 * 2),
                      onPressed: changeTheme,
                      isSelected: [isDarkMode, !isDarkMode],
                      children: const [
                        Icon(Icons.dark_mode),
                        Icon(Icons.light_mode),
                      ],
                    ),
                  ),
                  SizedBox(height: RS.height20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: RS.width15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                    ),
                    child: ExpansionTileCard(
                      borderRadius: BorderRadius.circular(15),
                      elevation: 0,
                      title: Text(AppString.color.tr),
                      leading: Image.asset(
                        AppImagePath.very_good3,
                        width: RS.w10 * 4,
                        height: RS.w10 * 4,
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      userController.changePrimaryColor(0),
                                  child: CircleAvatar(
                                    radius: RS.w10 * 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.priPinkClr,
                                    child:
                                        userController.userModel!.colorIndex ==
                                                0
                                            ? Icon(Icons.done)
                                            : null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      userController.changePrimaryColor(1),
                                  child: CircleAvatar(
                                    radius: RS.w10 * 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.priYellowClr,
                                    child:
                                        userController.userModel!.colorIndex ==
                                                1
                                            ? Icon(Icons.done)
                                            : null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      userController.changePrimaryColor(2),
                                  child: CircleAvatar(
                                    radius: RS.w10 * 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.priGreenClr,
                                    child:
                                        userController.userModel!.colorIndex ==
                                                2
                                            ? Icon(Icons.done)
                                            : null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      userController.changePrimaryColor(3),
                                  child: CircleAvatar(
                                    radius: RS.w10 * 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.priBluishClr,
                                    child:
                                        userController.userModel!.colorIndex ==
                                                3
                                            ? Icon(Icons.done)
                                            : null,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      userController.changePrimaryColor(4),
                                  child: CircleAvatar(
                                    radius: RS.w10 * 2,
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.priPubbleClr,
                                    child:
                                        userController.userModel!.colorIndex ==
                                                4
                                            ? Icon(Icons.done)
                                            : null,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: RS.height20),
                  _customListTIle(
                    title: AppString.background.tr,
                    subTitle: AppConstant
                        .backgroundLists[
                            userController.userModel?.backgroundIndex ?? 0]
                        .description,
                    imagePath: AppImagePath.very_good4,
                    onTap: () => Get.to(() => const SetBackgroundScreen()),
                  ),
                  SizedBox(height: RS.height15),
                  _customListTIle(
                    title: '${AppString.feal.tr} ${AppString.icon.tr}',
                    subTitle: AppConstant
                        .fealIconLists[
                            userController.userModel?.fealIconIndex ?? 0]
                        .description,
                    imagePath: AppImagePath.very_good5,
                    onTap: () => Get.to(() => const SetFealIconScreen()),
                  ),
                  SizedBox(height: RS.height15),
                  _customListTIle(
                    title: 'Change Language',
                    subTitle: AppString.setLanguage.tr,
                    imagePath: AppImagePath.good1,
                    onTap: () {},
                    widget: DropdownButton(
                        // isDense: true,
                        underline: const SizedBox(),
                        items: [
                          if (isEn) ...[
                            DropdownMenuItem(
                              value: AppString.koreanText.tr,
                              child: const Text('Korean'),
                            ),
                            DropdownMenuItem(
                              value: AppString.japaneseText.tr,
                              child: const Text('Japenese'),
                            ),
                          ],
                          if (isKo) ...[
                            DropdownMenuItem(
                              value: AppString.japaneseText.tr,
                              child: Text(
                                  'Japenese (${AppString.japaneseText.tr})'),
                            ),
                            DropdownMenuItem(
                              value: AppString.englishText.tr,
                              child:
                                  Text('English (${AppString.englishText.tr})'),
                            ),
                          ],
                          if (isJp) ...[
                            DropdownMenuItem(
                              value: AppString.koreanText.tr,
                              child:
                                  Text('Korean (${AppString.koreanText.tr})'),
                            ),
                            DropdownMenuItem(
                              value: AppString.englishText.tr,
                              child:
                                  Text('English (${AppString.englishText.tr})'),
                            ),
                          ],
                        ],
                        onChanged: changeSystemLanguage),
                  ),
                  SizedBox(height: RS.height20),
                  _customListTIle(
                    imagePath: AppImagePath.very_good1,
                    title: AppString.regularSchedule.tr,
                    onTap: () {
                      Get.to(() => const SettingAlramScreen());
                    },
                  ),
                  SizedBox(height: RS.height20),
                  _customListTIle(
                    title: AppString.fnOrErorreport.tr,
                    subTitle: AppString.tipOffMessage.tr,
                    iconData: Icons.mail,
                    onTap: () async {
                      final Email email = Email(
                        body: AppString.reportMsgContect.tr,
                        subject:
                            '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
                        recipients: ['visionwill3322@gmail.com'],
                        isHTML: false,
                      );
                      try {
                        await FlutterEmailSender.send(email);
                      } catch (e) {
                        bool result = await AppDialog.errorNoEnrolledEmail();
                        if (result) {
                          AppFunction.copyWord('visionwill3322@gmail.com');
                        }
                      }
                    },
                  ),
                  SizedBox(height: RS.height20),
                ],
              ),
            );
          });
  }

  void changeSystemLanguage(v) async {
    if (displayLanguage == v) {
      return;
    }
    displayLanguage = v!;

    if (displayLanguage == AppString.koreanText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ko');
      Get.updateLocale(const Locale('ko'));
    } else if (displayLanguage == AppString.japaneseText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ja');
      Get.updateLocale(const Locale('ja'));
    } else {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'en');
      Get.updateLocale(const Locale('en'));
    }
    await Future.delayed(const Duration(milliseconds: 500));

    bool result = await AppDialog.changeSystemLanguage();

    if (result && kReleaseMode) {
      exit(0);
    }

    setState(() {});
    setState(() {});
  }

  Widget _customListTIle({
    required String title,
    String? subTitle,
    IconData? iconData,
    String? imagePath,
    required Function() onTap,
    Widget? widget,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: RS.width15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: RS.width14,
        ),
        title: Text(
          title,
          maxLines: 1,
        ),
        trailing: widget,
        subtitle: subTitle == null
            ? null
            : Text(
                subTitle,
                maxLines: isEn ? 2 : 1,
              ),
        leading: iconData == null && imagePath != null
            ? Image.asset(
                imagePath,
                width: RS.w10 * 4,
                height: RS.w10 * 4,
              )
            : Icon(
                iconData,
                color: AppColors.primaryColor,
              ),
        onTap: onTap,
      ),
    );
  }
}
