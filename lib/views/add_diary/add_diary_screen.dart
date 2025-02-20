import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/open_close_container.dart';
import 'package:ours_log/controller/add_diary_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/add_diary/widgets/feal_selector.dart';
import 'package:ours_log/views/add_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/add_diary/widgets/morning_lunch_evening_blood_pressure_widget.dart';
import 'package:ours_log/views/add_diary/widgets/morning_lunch_evening_temp_and_pulse_widget.dart';

class AddDiaryScreen extends StatelessWidget {
  AddDiaryScreen({
    super.key,
    required this.selectedDay,
    this.diaryModel,
  });

  final DateTime selectedDay;
  final DiaryModel? diaryModel;

  late AddDiaryController addDiaryController;
  @override
  Widget build(BuildContext context) {
    addDiaryController = Get.put(
      AddDiaryController(
        selectedDay: selectedDay,
        diaryModel: diaryModel,
      ),
    );
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: AppString.saveText.tr,
              onTap: addDiaryController.onTapSaveBtn,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GetBuilder<AddDiaryController>(builder: (addDiaryController) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              controller: addDiaryController.scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: RS.h10,
                  horizontal: RS.width20,
                ),
                child: GetBuilder<UserController>(builder: (userController) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const FealSelector(),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.weight.tr,
                        widget: CustomTextFormField(
                          controller: addDiaryController.weightCtls[0],
                          hintText: AppString.weight.tr,
                          sufficIcon: Text(
                            'kg',
                            style: textFieldSufficStyle,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          maxLength: 5,
                        ),
                      ),
                      SizedBox(height: RS.h10 * 2),
                      CustomExpansionCard(
                        title: AppString.temperature.tr,
                        initiallyExpanded: userController
                            .userModel!.userUtilModel.expandedTemperature,
                        onExpansionChanged:
                            userController.toggleExpandedTemperature,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MorningLunchEveningTempAndPulseWidget(
                            controllers: addDiaryController.temperatureCtls,
                            label: AppString.temperature.tr,
                            sufficText: '°C',
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            maxLength: 5,
                          ),
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.pulse.tr,
                        initiallyExpanded: userController
                            .userModel!.userUtilModel.expandedPulse,
                        onExpansionChanged: userController.toggleExpandedPulse,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MorningLunchEveningTempAndPulseWidget(
                            controllers: addDiaryController.pulseCtls,
                            label: AppString.pulse.tr,
                            sufficText: '${AppString.count.tr}/min',
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                          ),
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.bloodPressure.tr,
                        initiallyExpanded: userController
                            .userModel!.userUtilModel.expandedBloodPressure,
                        onExpansionChanged:
                            userController.toggleExpandedbloodPressure,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MorningLunchEveningBloodPressureWidget(
                            maxControllers:
                                addDiaryController.maxBloodPressureCtls,
                            minControllers:
                                addDiaryController.minBloodPressureCtls,
                            label: AppString.bloodPressure.tr,
                            sufficText: 'mm Hg',
                          ),
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ExpansionIconCard(
                        initiallyExpanded: userController
                            .userModel!.userUtilModel.expandedPainLevel,
                        onExpansionChanged:
                            userController.toggleExpandedPainLevel,
                        icons: AppConstant.zeroToNineIcons,
                        label: AppString.painLevel.tr,
                        isOnlyOne: true,
                        selectedIconIndexs: addDiaryController.painFulIndex,
                      ),
                      SizedBox(height: RS.height20),
                      // ColTextAndWidget(
                      //   label: AppString.whatDidYouHintMsg.tr,
                      //   widget: CustomTextFormField(
                      //     hintText: AppString.plzEnterTextMsg.tr,
                      //     controller: addDiaryController.whatToDoController,
                      //     maxLines: 7,
                      //   ),
                      // ),
                      // SizedBox(height: RS.height20),
                      // ImageOfToday(
                      //   carouselSliderController:
                      //       addDiaryController.carouselSliderController,
                      //   label: AppString.photoOfToday.tr,
                      //   uploadFiles: addDiaryController.uploadFiles,
                      //   selectedPhotos: addDiaryController.selectedPhotos,
                      //   removePhoto: addDiaryController.removePhoto,
                      // ),
                      // SizedBox(height: RS.height20),
                      // ExpansionIconCard(
                      //   icons: AppConstant.weatherIcons,
                      //   label: AppString.weatherText.tr,
                      //   selectedIconIndexs:
                      //       addDiaryController.selectedWeatherIndexs,
                      // ),
                      // SizedBox(height: RS.height20),
                    ],
                  );
                }),
              ),
            ),
          );
        }),
      ),
    );
  }

  ColTextAndWidget mornEvenTempAndPulseWidget(
      List<TextEditingController> controllers,
      String label,
      String sufficText) {
    return ColTextAndWidget(
      label: label,
      widget: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controllers[0],
              hintText: AppString.morning.tr,
              sufficIcon: Text(
                sufficText,
                style: textFieldSufficStyle,
              ),
            ),
          ),
          // SizedBox(width: RS.width20),
          // Expanded(
          //   child: CustomTextFormField(
          //     controller: controllers[1],
          //     hintText: AppString.lunch.tr,
          //     sufficIcon: Text(
          //       sufficText,
          //       style: textFieldSufficStyle,
          //     ),
          //   ),
          // ),
          SizedBox(width: RS.width20),
          Expanded(
            child: CustomTextFormField(
              controller: controllers[2],
              hintText: AppString.evening.tr,
              sufficIcon: Text(
                sufficText,
                style: textFieldSufficStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ColTextAndWidget mornEvenBloodPressureWidget(
      List<TextEditingController> controllers,
      String label,
      String sufficText) {
    return ColTextAndWidget(
      label: label,
      widget: Column(
        children: [
          Row(
            children: [
              Text(AppString.morning.tr),
              SizedBox(width: RS.w10),
              Expanded(
                child: CustomTextFormField(
                  controller: controllers[0],
                  hintText: '최고 혈압',
                  sufficIcon: Text(
                    sufficText,
                    style: textFieldSufficStyle,
                  ),
                ),
              ),
              SizedBox(width: RS.w10 * 1.5),
              Expanded(
                child: CustomTextFormField(
                  controller: controllers[2],
                  hintText: '최저 혈압',
                  sufficIcon: Text(
                    sufficText,
                    style: textFieldSufficStyle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: RS.h10),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: controllers[0],
                  hintText: AppString.morning.tr,
                  sufficIcon: Text(
                    sufficText,
                    style: textFieldSufficStyle,
                  ),
                ),
              ),
              SizedBox(width: RS.width20),
              Expanded(
                child: CustomTextFormField(
                  controller: controllers[2],
                  hintText: AppString.evening.tr,
                  sufficIcon: Text(
                    sufficText,
                    style: textFieldSufficStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        DateFormat.MMMMEEEEd(Get.locale.toString()).format(selectedDay),
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
