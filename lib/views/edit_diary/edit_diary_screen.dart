import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/models/is_expandtion_type.dart';
import 'package:ours_log/common/theme/theme.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/open_close_container.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/models/poop_condition_type.dart';
import 'package:ours_log/views/edit_diary/widgets/day_done_pill_row.dart';
import 'package:ours_log/views/edit_diary/widgets/feal_selector.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/edit_diary/widgets/input_health_day_period.dart';
import 'package:ours_log/views/edit_diary/widgets/poop_health_day_period.dart';

// ignore: must_be_immutable
class EditDiaryScreen extends StatelessWidget {
  EditDiaryScreen({
    super.key,
    required this.selectedDay,
    this.diaryModel,
  });

  final DateTime selectedDay;
  final DiaryModel? diaryModel;

  late EditDiaryController editDiaryController;
  @override
  Widget build(BuildContext context) {
    editDiaryController = Get.put(
      EditDiaryController(
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
              onTap: editDiaryController.onTapSaveBtn,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GetBuilder<EditDiaryController>(builder: (editDiaryController) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              controller: editDiaryController.scrollController,
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
                      if (editDiaryController.donePillDayModels.isNotEmpty)
                        const DayDonePillRow(),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.weight.tr,
                        widget: CustomTextFormField(
                          controller: editDiaryController.weightCtls[0],
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
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.temperature.tr,
                        initiallyExpanded: userController
                                .userModel!
                                .userUtilModel
                                .expandedFields[IsExpandtionType.temperature] ??
                            false,
                        onExpansionChanged: (bool v) => userController
                            .toggleExpanded(IsExpandtionType.temperature),
                        child: InputHealthDayPeriod(
                          controllers: editDiaryController.temperatureCtls,
                          sufficText: '°C',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          maxLength: 5,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.pulse.tr,
                        initiallyExpanded: userController
                                .userModel!
                                .userUtilModel
                                .expandedFields[IsExpandtionType.pulse] ??
                            false,
                        onExpansionChanged: (bool v) => userController
                            .toggleExpanded(IsExpandtionType.pulse),
                        child: InputHealthDayPeriod(
                          controllers: editDiaryController.pulseCtls,
                          sufficText: '${AppString.count.tr}/min',
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.bloodPressure.tr,
                        initiallyExpanded: userController
                                    .userModel!.userUtilModel.expandedFields[
                                IsExpandtionType.bloodPressure] ??
                            false,
                        onExpansionChanged: (bool v) => userController
                            .toggleExpanded(IsExpandtionType.bloodPressure),
                        child: InputHealthDayPeriod(
                          controllers: editDiaryController.maxBloodPressureCtls,
                          controllers2:
                              editDiaryController.minBloodPressureCtls,
                          hintText: AppString.maxBloodPressure.tr,
                          hintText2: AppString.minBloodPressure.tr,
                          sufficText: 'mm Hg',
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.stool.tr,
                        initiallyExpanded: userController
                                    .userModel!.userUtilModel.expandedFields[
                                IsExpandtionType.poopCondition] ??
                            false,
                        onExpansionChanged: (bool v) => userController
                            .toggleExpanded(IsExpandtionType.poopCondition),
                        child: const PoopDayPeriod(),
                      ),
                      SizedBox(height: RS.h10),
                      ExpansionIconCard(
                        initiallyExpanded: userController
                                .userModel!
                                .userUtilModel
                                .expandedFields[IsExpandtionType.painLevel] ??
                            false,
                        onExpansionChanged: (bool v) => userController
                            .toggleExpanded(IsExpandtionType.painLevel),
                        icons: AppConstant.zeroToNineIcons,
                        label: AppString.painLevel.tr,
                        isOnlyOne: true,
                        selectedIconIndexs: editDiaryController.painFulIndex,
                      ),
                      SizedBox(height: RS.h10),
                      CustomExpansionCard(
                        title: AppString.memo.tr,
                        child: Column(
                          children: [
                            ColTextAndWidget(
                              label: AppString.healthMemo,
                              widget: CustomTextFormField(
                                hintText: AppString.plzEnterTextMsg.tr,
                                controller:
                                    editDiaryController.whatToDoController,
                                maxLines: 7,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: RS.w10 * 2),
                              child: const Divider(),
                            ),
                            ImageOfToday(
                              carouselSliderController:
                                  editDiaryController.carouselSliderController,
                              label: AppString.photo.tr,
                              uploadFiles: editDiaryController.uploadFiles,
                              selectedPhotos:
                                  editDiaryController.selectedPhotos,
                              removePhoto: editDiaryController.removePhoto,
                            ),
                          ],
                        ),
                      ),
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

  AppBar _appBar() {
    return AppBar(
      title: Text(
        DateFormat.MMMMEEEEd(Get.locale.toString()).format(selectedDay),
      ),
    );
  }
}
