import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/models/blood_pressure_model.dart';
import 'package:ours_log/models/regular_task_modal.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/models/user_util_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/respository/user_respository.dart';
import 'package:ours_log/views/splash_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await _initializeTimeZone();
  await initHive();

  runApp(const MyApp());
}

Future<void> _initializeTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  print("📌 현재 타임존: $currentTimeZone");
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? systemLanguage;
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    getUsresSetting();
  }

  void getUsresSetting() async {
    systemLanguage =
        await SettingRepository.getString(AppConstant.settingLanguageKey);

    bool? isDarkMode =
        await SettingRepository.getBool(AppConstant.isDarkModeKey);

    setState(
      () {
        if (systemLanguage!.isEmpty) {
          systemLanguage = Get.deviceLocale.toString();
        }
        if (isDarkMode != null) {
          if (isDarkMode) {
            themeMode = ThemeMode.dark;
          } else {
            themeMode = ThemeMode.light;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return systemLanguage == null
        ? Container()
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ours Log',
            theme: lightTheme(systemLanguage!),
            darkTheme: darkTheme(systemLanguage!),
            themeMode: themeMode!,
            fallbackLocale: const Locale('ko', 'KR'),
            translations: AppTranslations(),
            locale: Locale(systemLanguage!),
            home: const SplashScreen(),
          );
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AppConstant.regularTaskModelHiveId)) {
    Hive.registerAdapter(RegularTaskModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.notificationModelHiveId)) {
    Hive.registerAdapter(NotificationModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.taskModelHiveId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.userUtilModelHiveId)) {
    Hive.registerAdapter(UserUtilModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.userModelHiveId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.diaryModelHiveId)) {
    Hive.registerAdapter(DiaryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.bloodPressureModelHiveId)) {
    Hive.registerAdapter(BloodPressureModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.healthModelHiveId)) {
    Hive.registerAdapter(HealthModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.hospitalLogModelHiveId)) {
    Hive.registerAdapter(HospitalLogModelAdapter());
  }

  // if (kDebugMode) {
  //   HospitalLogRepository hospitalLogRepository = HospitalLogRepository();

  //   var hospitalLogModels = await hospitalLogRepository.select();
  //   if (hospitalLogModels.isEmpty) {
  //     for (var dummyHospitalLogModel in dummyHospitalLogModels) {
  //       hospitalLogRepository.insert(dummyHospitalLogModel);
  //     }
  //   }
  // }
}
