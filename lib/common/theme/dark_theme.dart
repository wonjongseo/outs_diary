import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ours_log/common/utilities/app_color.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: "ZenMaruGothic",
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
    backgroundColor: AppColors.greyBackground,
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    scaffoldBackgroundColor: AppColors.greyBackground,
    // extensions: [
    //   CustomThemeExtension.darkMode,
    // ],
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greyBackground,
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
      backgroundColor: AppColors.greyBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.greyBackground,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withOpacity(.6),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greenDark,
      tileColor: AppColors.black,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(AppColors.greenDark),
      trackColor: MaterialStatePropertyAll(Color(0xFF344047)),
    ),
  );
}
