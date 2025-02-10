import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';

ThemeData lightTheme(String systemLanguage) {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: ThemeData.light().textTheme.apply(
        fontFamily:
            systemLanguage.contains('ja') ? "ZenMaruGothic" : "CookieRunFont"),
    backgroundColor: Colors.white.withOpacity(.95),

    scaffoldBackgroundColor: Colors.white.withOpacity(.95),
    // extensions: [CustomThemeExtension.lightMode],
    cardTheme: CardTheme(elevation: 2),
    appBarTheme: const AppBarTheme(
      // backgroundColor: AppColors.primaryColor,
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
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
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greenDark,
      tileColor: AppColors.white,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.grey[700]!),
      overlayColor: MaterialStateProperty.all(Colors.red),
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

TextStyle get boldStyle {
  return TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: RS.width20,
  );
}

TextStyle get weekdayStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : AppColors.greyBackground,
  );
}
