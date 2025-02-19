import 'dart:developer';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
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
    log("OPEN SettingBody");

    return settingLanguage.isEmpty
        ? Container()
        : GetBuilder<UserController>(builder: (userController) {
            return Column(
              children: [
                SizedBox(height: RS.height20),
                _customListTIle(
                  title: AppString.theme.tr,
                  subTitle: isDarkMode
                      ? AppString.darkMode.tr
                      : AppString.lightMode.tr,
                  imagePath: AppImagePath.good2,
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
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: ExpansionTileCard(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 0,
                    title: const Text('앱 색상'),
                    leading: Image.asset(
                      AppImagePath.good2,
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
                                  backgroundColor: AppColors.pinkClr,
                                  child:
                                      userController.userModel!.colorIndex == 0
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
                                  backgroundColor: AppColors.yellowClr,
                                  child:
                                      userController.userModel!.colorIndex == 1
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
                                  backgroundColor: AppColors.greenClr,
                                  child:
                                      userController.userModel!.colorIndex == 2
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
                                  backgroundColor: AppColors.bluishClr,
                                  child:
                                      userController.userModel!.colorIndex == 3
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
                                  backgroundColor: AppColors.pubbleClr,
                                  child:
                                      userController.userModel!.colorIndex == 4
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

                GetBuilder<UserController>(builder: (controller) {
                  return _customListTIle(
                    title: AppString.background.tr,
                    subTitle: AppConstant
                        .backgroundLists[
                            controller.userModel?.backgroundIndex ?? 0]
                        .description,
                    imagePath: AppImagePath.very_good2,
                    onTap: () => Get.to(() => const SetBackgroundScreen()),
                  );
                }),
                SizedBox(height: RS.height15),

                _customListTIle(
                  title: '기분 아이콘 ',
                  subTitle: '',
                  imagePath: AppImagePath.soso2,
                  onTap: () => Get.to(() => const SetFealIconScreen()),
                ),
                // const SetBackgroundScreen(),
                SizedBox(height: RS.height15),
                _customListTIle(
                  title: 'Change Language',
                  subTitle: AppString.setLanguage.tr,
                  imagePath: AppImagePath.bad2,
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
                            child:
                                Text('Japenese (${AppString.japaneseText.tr})'),
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
                            child: Text('Korean (${AppString.koreanText.tr})'),
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
                const Spacer(flex: 1),
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
                    // try {
                    //   await FlutterEmailSender.send(email);
                    // } catch (e) {
                    //   bool result = await CommonDialog.errorNoEnrolledEmail();
                    //   if (result) {
                    //     AppFunction.copyWord('visionwill3322@gmail.com');
                    //   }
                    // }
                  },
                ),
                const Spacer(flex: 3),
              ],
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
