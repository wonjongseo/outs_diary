import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ours_log/common/theme/dark_theme.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';
import 'package:ours_log/views/graph/graph_screen.dart';
import 'package:ours_log/views/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(Get.locale.toString()),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      fallbackLocale: const Locale('ko', 'KR'),
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      // home: AddDiaryScreen(selectedDay: now),
      // home: MyWidget(
      //   title: 'tt',
      // ),
      home: HomeScreen(),
    );
  }
}
