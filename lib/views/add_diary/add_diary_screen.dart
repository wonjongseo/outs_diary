import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/open_close_container.dart';
import 'package:ours_log/views/add_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key, required this.selectedDay});

  final DateTime selectedDay;

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  int selectedFealIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: RS.width10),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  AppString.saveText.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: RS.width20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: RS.height10,
              horizontal: RS.width20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ColTextAndWidget(
                    label: AppString.whatDidYouHintMsg.tr,
                    widget: CustomTextFormField(
                      hintText: AppString.plzEnterTextMsg.tr,
                      maxLines: 7,
                    ),
                  ),
                  SizedBox(height: RS.height20),
                  const ImageOfToday(),
                  SizedBox(height: RS.height20),
                  ColTextAndWidget(
                    label: AppString.health.tr,
                    widget: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                hintText: AppString.temperature.tr,
                              ),
                            ),
                            SizedBox(width: RS.width20),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: AppString.baiscTemperature.tr,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: RS.height20),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                hintText: AppString.bloodPressure.tr,
                              ),
                            ),
                            SizedBox(width: RS.width20),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: AppString.weightText.tr,
                              ),
                            ),
                            SizedBox(width: RS.width20),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: AppString.pulse.tr,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: RS.height30),
                        // ONLY Gril
                        CustomTextFormField(
                          hintText: AppString.baiscTemperature.tr,
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: RS.height20),
                  ExpansionIconCard(
                      icons: AppConstant.weatherIcons,
                      label: AppString.weatherText.tr),
                  // ExpansionIconCard(
                  //   label: AppString.peopleText.tr,
                  //   icons: AppConstant.dummyIcons,
                  // ),
                  // SizedBox(height: RS.height20),

                  // ExpansionIconCard(
                  //   label: AppString.weatherText.tr,
                  //   icons: [
                  //     ...AppConstant.weatherIcons,
                  //   ],
                  // ),
                  SizedBox(height: RS.height20),
                  Container(
                    padding: EdgeInsets.all(RS.width8),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColors.backgroundDark
                          : Colors.white,
                      borderRadius: BorderRadius.circular(RS.height10),
                    ),
                    child: Column(
                      children: [
                        Text(AppString.howFealToday.tr),
                        SizedBox(height: RS.height10 / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            AppConstant.fillingIcons.length,
                            (index) {
                              bool isSelected = selectedFealIndex == index;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFealIndex = index;
                                    });
                                  },
                                  child: Image.asset(
                                    AppConstant.fillingIcons[index],
                                    width: isSelected
                                        ? RS.width10 * 5.5
                                        : RS.width10 * 5,
                                    colorBlendMode: BlendMode.modulate,
                                    color: isSelected
                                        ? null
                                        : Colors.white.withOpacity(.5),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: RS.height20),
                  // OpenCloseContainer(
                  //   label: AppString.fealText.tr,
                  //   icons: AppConstant.fillingIcons,
                  // ),
                  SizedBox(height: RS.height20),

                  SizedBox(height: RS.height20),

                  SizedBox(height: RS.height20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        DateFormat.MMMMEEEEd(Get.locale.toString()).format(widget.selectedDay),
      ),
    );
  }
}

/**
 * 
 * 体温(基礎体温、体温)　// ok
体重// ok 
血圧 // ok 
生理期間
自覚症状

日記

薬とか採血結果はスキャンして画像で整理

脈拍

 */
