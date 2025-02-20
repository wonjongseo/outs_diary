import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/controller/notification_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/respository/dairy_respository.dart';
import 'package:ours_log/respository/user_respository.dart';
import 'package:ours_log/views/Hospital_Log/hospital_log_body.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/views/background/background_widget.dart';
import 'package:ours_log/views/diary/diary_body.dart';
import 'package:ours_log/views/graph/graph_body.dart';
import 'package:ours_log/views/manage_alrem/manage_alrem_body.dart';
import 'package:ours_log/views/setting/setting_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late DiaryController diaryController;
  int bodyIndex = 0;
  List<Widget> bodys = [];

  @override
  void initState() {
    Get.put(UserController());
    Get.put(DiaryController());
    Get.put(HospitalLogController());
    setBodys();
    super.initState();
  }

  void setBodys() {
    bodys.add(DiaryBody());
    bodys.add(HospitalLogBody());
    bodys.add(ManageAlermBody());
    bodys.add(GraphBody());
    bodys.add(SettingBody());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [bottomNavigtionBar()],
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () async {
        NotificationService notification = NotificationService();
        notification.cancelAllNotifications();
        UserModelRepository().deleteAll();
        DiaryRepository().deleteAll();
      }),
      body: SafeArea(
        child: BackgroundWidget(
          widget: Padding(
            padding: EdgeInsets.symmetric(
              vertical: RS.h10 * 3,
              horizontal: RS.w10 * 1.2,
            ),
            child: bodys[bodyIndex],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigtionBar() {
    return GetBuilder<UserController>(builder: (context) {
      return Container(
        color: Colors.red,
        child: BottomNavigationBar(
          currentIndex: bodyIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            bodyIndex = value;
            setState(() {});
          },
          selectedItemColor: AppColors.primaryColor,
          items: [
            BottomNavigationBarItem(
                label: AppString.healthLog.tr, icon: Text('')),
            BottomNavigationBarItem(
                label: AppString.hospitalVisitLog.tr, icon: Text('')),
            BottomNavigationBarItem(
                label: AppString.scheduleManagement.tr, icon: Text('')),
            BottomNavigationBarItem(
                label: AppString.healthGraph.tr, icon: Text('')),
            BottomNavigationBarItem(
                label: AppString.settingTr.tr, icon: Text('')),
          ],
        ),
      );
    });
  }
}
