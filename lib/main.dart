import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ours_log/respository/hospital_log_repository.dart';
import 'package:ours_log/views/Hospital_Log/hospital_log_body.dart';
import 'package:ours_log/common/theme/dark_theme.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/health_model.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/home/main_screen.dart';

//flutter pub run build_runner build
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

  if (!Hive.isAdapterRegistered(AppConstant.hospitalLogModelHiveId)) {
    Hive.registerAdapter(HospitalLogModelAdapter());
  }

  if (kDebugMode) {
    HospitalLogRepository hospitalLogRepository = HospitalLogRepository();

    var hospitalLogModels = await hospitalLogRepository.select();
    if (hospitalLogModels.isEmpty) {
      for (var dummyHospitalLogModel in dummyHospitalLogModels) {
        hospitalLogRepository.insert(dummyHospitalLogModel);
      }
    }
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
