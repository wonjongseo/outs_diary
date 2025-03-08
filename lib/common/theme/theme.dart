import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';

import 'package:flutter/services.dart';

ThemeData lightTheme(String systemLanguage) {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily:
              systemLanguage.contains('ja') ? "ZenMaruGothic" : "CookieRunFont",
        ),
    // scaffoldBackgroundColor: Colors.white.withOpacity(.95),
    scaffoldBackgroundColor: AppColors.white,
    cardTheme: const CardTheme(elevation: 2),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      unselectedLabelColor: Color(0xFFB3D9D2),
      labelColor: Colors.black,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenLight,
        foregroundColor: AppColors.white,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black.withOpacity(.6),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.white,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.greenDark,
      tileColor: AppColors.white,
      textColor: Colors.black,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.grey[700]!),
      overlayColor: WidgetStateProperty.all(Colors.red),
      checkColor: MaterialStateProperty.all(AppColors.primaryColor),
      fillColor: MaterialStateProperty.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.grey[200];
          }
          return Colors.white;
        },
      ),
    ),
  );
}

ThemeData darkTheme(String systemLanguage) {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: AppColors.darkTextColor,
        fontFamily:
            systemLanguage.contains('ja') ? "ZenMaruGothic" : "CookieRunFont"),
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.greyDark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: AppColors.greenDark,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.greenDark,
          width: 2,
        ),
      ),
      unselectedLabelColor: AppColors.greyDark,
      labelColor: AppColors.greenDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenDark,
        foregroundColor: AppColors.black,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.darkBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.white.withOpacity(.6),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: AppColors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greenDark,
      tileColor: AppColors.black,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.greenDark),
      trackColor: WidgetStatePropertyAll(Color(0xFF344047)),
    ),
  );
}

Color get textWhiteOrBlack {
  return Get.isDarkMode ? AppColors.white : AppColors.darkBackground;
}

Color get textBlackOrWhite {
  return Get.isDarkMode ? AppColors.darkBackground : AppColors.white;
}

Color get boxBlackOrWhite {
  return Get.isDarkMode ? AppColors.black : AppColors.white;
}

Color get boxWhiteOrBlack {
  return Get.isDarkMode ? AppColors.white : AppColors.black;
}

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: 10 * 1.6,
    fontWeight: FontWeight.w400,
    color: textWhiteOrBlack,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    fontSize: 10 * 2,
    fontWeight: FontWeight.w600,
    color: textWhiteOrBlack,
  );
}

TextStyle get activeHintStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w100,
    color: textWhiteOrBlack,
  );
}

TextStyle get contentStyle {
  return TextStyle(
    color: Colors.grey[800],
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
}

TextStyle get subTitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
  );
}

TextStyle get boldStyle {
  return TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
}

TextStyle get weekdayStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : AppColors.darkBackground,
  );
}

TextStyle get textFieldSufficStyle {
  return TextStyle(color: Colors.grey[500]);
}

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
