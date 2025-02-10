import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ours_log/common/theme/dark_theme.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/views/home/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await initHive();

  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AppConstant.diaryModelHiveId)) {
    Hive.registerAdapter(DiaryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.healthModelHiveId)) {
    Hive.registerAdapter(HealthModelAdapter());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme(Get.locale.toString()),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      fallbackLocale: const Locale('ko', 'KR'),
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      home: const MainScreen(),
    );
  }
}
