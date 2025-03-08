import 'dart:developer';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app.dialog.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

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
  bool isColorPickerOpen = false;
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

  TextStyle headingstyle() {
    return TextStyle(
      fontSize: 10 * 1.8,
      fontWeight: FontWeight.w600,
      color: isDarkMode ? AppColors.white : AppColors.black,
    );
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
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppString.fotTaste.tr,
                          style: headingstyle(),
                        ),
                      ),
                      _fealIcon(userController),
                      _background(userController),
                      _color(userController),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppString.systemSetting.tr,
                          style: headingstyle(),
                        ),
                      ),
                      _theme(),
                      _language(),
                      _notification(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppString.another.tr,
                          style: headingstyle(),
                        ),
                      ),
                      _feadbackAndError(),
                    ],
                  ),
                ],
              ),
            );
          });
  }

  ListTile _color(UserController userController) {
    return ListTile(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      title: Text(AppString.color.tr),
      onTap: () {
        isColorPickerOpen = !isColorPickerOpen;
        setState(() {});
      },
      trailing: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 10 * 1.8,
      ),
      isThreeLine: true,
      subtitle: AnimatedContainer(
        padding: EdgeInsets.only(top: 10 * 2),
        height: isColorPickerOpen ? 10 * 9 : 10 * 2,
        duration: const Duration(milliseconds: 300),
        child: !isColorPickerOpen
            ? null
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => userController.changePrimaryColor(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 10 * 2,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.priPinkClr,
                        child: userController.userModel!.colorIndex == 0
                            ? const Icon(Icons.done)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => userController.changePrimaryColor(1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 10 * 2,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.priYellowClr,
                        child: userController.userModel!.colorIndex == 1
                            ? Icon(Icons.done)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => userController.changePrimaryColor(2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 10 * 2,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.priGreenClr,
                        child: userController.userModel!.colorIndex == 2
                            ? Icon(Icons.done)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => userController.changePrimaryColor(3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 10 * 2,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.priBluishClr,
                        child: userController.userModel!.colorIndex == 3
                            ? Icon(Icons.done)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => userController.changePrimaryColor(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 10 * 2,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.priPubbleClr,
                        child: userController.userModel!.colorIndex == 4
                            ? Icon(Icons.done)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _feadbackAndError() {
    return _customListTIle(
      title: AppString.fnOrErorreport.tr,
      subTitle: AppString.tipOffMessage.tr,
      iconData: Icons.mail,
      onTap: () async {
        final Email email = Email(
          body: AppString.reportMsgContect.tr,
          subject: '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
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
    );
  }

  Widget _notification() {
    return _customListTIle(
      title: AppString.notification.tr,
      onTap: () {
        Get.to(() => const SettingAlramScreen());
      },
    );
  }

  Widget _theme() {
    return _customListTIle(
      title: AppString.theme.tr,
      subTitle: isDarkMode ? AppString.darkMode.tr : AppString.lightMode.tr,
      onTap: () => changeTheme(isDarkMode ? 0 : 1),
      widget: ToggleButtons(
        borderRadius: BorderRadius.circular(10 * 2),
        onPressed: changeTheme,
        isSelected: [isDarkMode, !isDarkMode],
        children: const [
          Icon(Icons.dark_mode),
          Icon(Icons.light_mode),
        ],
      ),
    );
  }

  Widget _fealIcon(UserController userController) {
    return _customListTIle(
      title: '${AppString.feal.tr} ${AppString.icon.tr}',
      subTitle: AppConstant
          .fealIconLists[userController.userModel?.fealIconIndex ?? 0]
          .description,
      onTap: () => Get.to(() => const SetFealIconScreen()),
    );
  }

  Widget _background(UserController userController) {
    return _customListTIle(
      title: AppString.background.tr,
      subTitle: AppConstant
          .backgroundLists[userController.userModel?.backgroundIndex ?? 0]
          .description,
      onTap: () => Get.to(() => const SetBackgroundScreen()),
    );
  }

  ExpansionTileCard _color2(UserController userController) {
    return ExpansionTileCard(
      contentPadding: EdgeInsets.symmetric(horizontal: 10 * 1.3),
      elevation: 0,
      title: Text(
        AppString.color.tr,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          fontSize: 14,
        ),
      ),
      trailing: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
      ),
      expandedColor: boxWhiteOrBlack,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => userController.changePrimaryColor(0),
              child: CircleAvatar(
                radius: 10 * 2,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.priPinkClr,
                child: userController.userModel!.colorIndex == 0
                    ? const Icon(Icons.done)
                    : null,
              ),
            ),
            GestureDetector(
              onTap: () => userController.changePrimaryColor(1),
              child: CircleAvatar(
                radius: 10 * 2,
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
                radius: 10 * 2,
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
                radius: 10 * 2,
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
                radius: 10 * 2,
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
    required Function() onTap,
    Widget? widget,
  }) {
    return ListTile(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      subtitleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      title: Text(
        title,
        maxLines: 1,
      ),
      trailing: widget ??
          Icon(
            Icons.keyboard_arrow_right,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
      subtitle: subTitle == null
          ? null
          : Text(
              subTitle,
              maxLines: isEn ? 2 : 1,
            ),
      onTap: onTap,
    );
  }

  Widget _language() {
    return _customListTIle(
      title: 'Change Language',
      subTitle: AppString.setLanguage.tr,
      onTap: () {},
      widget: DropdownButton(
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
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
                child: Text('Japenese (${AppString.japaneseText.tr})'),
              ),
              DropdownMenuItem(
                value: AppString.englishText.tr,
                child: Text('English (${AppString.englishText.tr})'),
              ),
            ],
            if (isJp) ...[
              DropdownMenuItem(
                value: AppString.koreanText.tr,
                child: Text('Korean (${AppString.koreanText.tr})'),
              ),
              DropdownMenuItem(
                value: AppString.englishText.tr,
                child: Text('English (${AppString.englishText.tr})'),
              ),
            ],
          ],
          onChanged: changeSystemLanguage),
    );
  }
}

class ColorPickScreen extends StatefulWidget {
  const ColorPickScreen({super.key});

  @override
  State<ColorPickScreen> createState() => _ColorPickScreenState();
}

class _ColorPickScreenState extends State<ColorPickScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
