import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/setting/set_feal_icon_screen.dart';
import 'package:ours_log/views/setting/widgets/background1_sample.dart';
import 'package:ours_log/views/setting/set_background_widget.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  String settingLanguage = '';
  String displayLanguage = '';
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

  bool isDarkMode = Get.isDarkMode;

  void changeTheme(int index) {
    if (index == 0) {
      isDarkMode = true;
      Get.changeThemeMode(ThemeMode.dark);
    } else {
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
        : Column(
            children: [
              SizedBox(height: RS.height20),
              _customListTIle(
                title: '테마',
                subTitle: isDarkMode ? '다크 모드' : '라이트 모드',
                imagePath: AppImagePath.good2,
                onTap: () => changeTheme(isDarkMode ? 1 : 0),
                widget: ToggleButtons(
                  onPressed: changeTheme,
                  children: [
                    Icon(Icons.dark_mode),
                    Icon(Icons.light_mode),
                  ],
                  isSelected: [isDarkMode, !isDarkMode],
                ),
              ),
              SizedBox(height: RS.height15),
              _customListTIle(
                title: '배경 선택',
                subTitle: '',
                imagePath: AppImagePath.very_good2,
                onTap: () => Get.to(() => SetBackgroundScreen()),
              ),
              SizedBox(height: RS.height15),

              _customListTIle(
                title: '기분 아이콘 ',
                subTitle: '',
                imagePath: AppImagePath.soso2,
                onTap: () => Get.to(() => SetFealIconScreen()),
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

    // bool result = await CommonDialog.changeSystemLanguage();

    //   if (result) {
    /// /     exit(0);
    //   }

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
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.grey),
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
