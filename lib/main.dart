import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/controller/image_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/models/blood_pressure_model.dart';
import 'package:ours_log/models/day_period_type.dart';
import 'package:ours_log/models/done_pill_day_modal.dart';
import 'package:ours_log/models/poop_condition.dart';
import 'package:ours_log/models/poop_condition_type.dart';
import 'package:ours_log/models/regular_task_modal.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/models/notification_model.dart';
import 'package:ours_log/models/task_model.dart';
import 'package:ours_log/models/user_model.dart';
import 'package:ours_log/models/user_util_model.dart';
import 'package:ours_log/models/week_day_type.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/splash_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  initializeDateFormatting();
  await _initializeTimeZone();
  await initHive();

  runApp(const MyApp());
}

Future<void> _initializeTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  log("📌 Timezone: $currentTimeZone");
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
          themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
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
            title: 'My Medical Logs',
            theme: lightTheme(systemLanguage!),
            darkTheme: darkTheme(systemLanguage!),
            themeMode: themeMode!,
            fallbackLocale: const Locale('ko', 'KR'),
            translations: AppTranslations(),
            locale: Locale(systemLanguage!),
            home: const SplashScreen(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
  }
}

//flutter pub run change_app_package_name:main com.wonjongseo.my_medical_logs

Future<void> initHive() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AppConstant.poopConditionTypeHiveId)) {
    Hive.registerAdapter(PoopConditionTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.poopConditionModelHiveId)) {
    Hive.registerAdapter(PoopConditionModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.isExpandtionTypeHiveId)) {
    Hive.registerAdapter(IsExpandtionTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.donePillDayModelHiveId)) {
    Hive.registerAdapter(DonePillDayModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.weekDayTypeHiveId)) {
    Hive.registerAdapter(WeekDayTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.dayPeriodTypeHiveId)) {
    Hive.registerAdapter(DayPeriodTypeAdapter());
  }

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
}
// Android Command - flutter build appbundle
