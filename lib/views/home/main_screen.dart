import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/light_theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_image_path.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/add_diary/add_diary_screen.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/background/background2.dart';
import 'package:ours_log/views/home/bodys/diary_body.dart';
import 'package:ours_log/views/hospital_visit_log/hospital_visit_log_screen.dart';
import 'package:table_calendar/table_calendar.dart';

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
    Get.put(DiaryController());
    setBodys();
    super.initState();
  }

  void setBodys() {
    bodys.add(DiaryBody());
    bodys.add(HospitalVisitLogBody());
    bodys.add(Text('data2'));
    bodys.add(Text('data3'));
    bodys.add(Text('data4'));
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
      body: SafeArea(
          child: BackGround2(
        widget: bodys[bodyIndex],
      )),
    );
  }

  Widget bottomNavigtionBar() {
    return BottomNavigationBar(
      currentIndex: bodyIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      onTap: (value) {
        bodyIndex = value;
        setState(() {});
      },
      selectedLabelStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      selectedItemColor: AppColors.primaryColor,
      items: [
        BottomNavigationBarItem(label: '건강 기록', icon: Text('')),
        BottomNavigationBarItem(label: '병원 방문 기록', icon: Text('')),
        BottomNavigationBarItem(
            label: AppString.expensiveTextTr.tr, icon: Text('')),
        BottomNavigationBarItem(label: AppString.settingTr.tr, icon: Text('')),
      ],
    );
  }
}

class SelectedDiary extends StatelessWidget {
  const SelectedDiary({
    super.key,
    required this.diaryController,
  });

  final DiaryController diaryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.w10 * 2),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      diaryController.selectedDiary!.getFealImage,
                      width: RS.w10 * 6,
                    ),
                    SizedBox(width: RS.w10),
                    Text(
                      DateFormat.MMMEd(isKo ? 'ko' : 'ja')
                          .format(diaryController.selectedDiary!.dateTime),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(
                          () => AddDiaryScreen(
                            selectedDay:
                                diaryController.selectedDiary!.dateTime,
                            diaryModel: diaryController.selectedDiary,
                          ),
                        );
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.edit,
                        size: RS.width20,
                      ),
                    ),
                    IconButton(
                      onPressed: () => diaryController.delete(),
                      icon: FaIcon(
                        FontAwesomeIcons.trashCan,
                        size: RS.width20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            ColTextAndWidget(
              label: AppString.whatDidYouHintMsg.tr,
              widget: CustomTextFormField(
                hintText: diaryController.selectedDiary!.whatTodo,
                maxLines: (diaryController.selectedDiary!.whatTodo ?? '')
                    .split('\n')
                    .length,
              ),
            ),
            if (diaryController.selectedDiary!.imagePath != null &&
                diaryController.selectedDiary!.imagePath!.isNotEmpty)
              ColTextAndWidget(
                label: '이런 일 들 이 있었죠~?',
                widget: Row(
                  children: List.generate(
                    diaryController.selectedDiary!.imagePath!.length,
                    (index) {
                      return Container(
                        width: RS.w10 * 12,
                        height: RS.w10 * 12,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              File(
                                diaryController
                                    .selectedDiary!.imagePath![index],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
