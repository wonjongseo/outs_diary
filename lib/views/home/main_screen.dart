import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:ours_log/controller/background_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/views/Hospital_Log/hospital_log_body.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/views/background/background2.dart';
import 'package:ours_log/views/diary/diary_body.dart';
import 'package:ours_log/views/graph/graph_body.dart';
import 'package:ours_log/views/setting/setting_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DiaryController diaryController;
  int bodyIndex = 3;
  List<Widget> bodys = [];

  @override
  void initState() {
    Get.put(BackgroundController());
    Get.put(DiaryController());
    Get.put(HospitalLogController());
    setBodys();
    super.initState();
  }

  void setBodys() {
    bodys.add(DiaryBody());
    bodys.add(HospitalLogBody());
    bodys.add(GraphBody());
    bodys.add(SettingBody());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [bottomNavigtionBar()],
      ),
      body: BackGround2(
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.w10 * 1.2),
          child: bodys[bodyIndex],
        ),
      ),
    );
  }

  Widget bottomNavigtionBar() {
    return BottomNavigationBar(
      currentIndex: bodyIndex,
      type: BottomNavigationBarType.fixed,
      // backgroundColor:
      //     Get.isDarkMode ? AppColors.greyBackground : Colors.grey[100]!,
      onTap: (value) {
        bodyIndex = value;
        setState(() {});
      },
      selectedLabelStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      selectedItemColor: AppColors.primaryColor,
      items: [
        BottomNavigationBarItem(label: AppString.healthLog.tr, icon: Text('')),
        BottomNavigationBarItem(
            label: AppString.hospitalVisitLog.tr, icon: Text('')),
        BottomNavigationBarItem(
            label: AppString.healthGraph.tr, icon: Text('')),
        BottomNavigationBarItem(label: AppString.settingTr.tr, icon: Text('')),
      ],
    );
  }
}
