import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/common/widgets/open_close_container.dart';
import 'package:ours_log/controller/diary_controller.dart';
import 'package:ours_log/models/diary_model.dart';
import 'package:ours_log/views/add_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/image_picker_screen.dart';

class AddDiaryScreen extends StatefulWidget {
  const AddDiaryScreen({super.key, required this.selectedDay, this.diaryModel});

  final DateTime selectedDay;
  final DiaryModel? diaryModel;

  @override
  State<AddDiaryScreen> createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  int selectedFealIndex = -1;
  DiaryController diaryController = Get.find<DiaryController>();

  List<int> selectedWeatherIndexs = [];
  List<File> uploadFiles = [];
  late TextEditingController whatToDoController;

  @override
  void initState() {
    super.initState();
    whatToDoController = TextEditingController();

    if (widget.diaryModel != null) {
      whatToDoController.text = widget.diaryModel!.whatTodo ?? '';

      if (widget.diaryModel!.imagePath != null) {
        for (var image in widget.diaryModel!.imagePath!) {
          uploadFiles.add(File(image));
        }
      }

      selectedWeatherIndexs = widget.diaryModel!.weatherIconIndex ?? [];
      selectedFealIndex = widget.diaryModel!.fealIndex;

      setState(() {});
    }
  }

  void onTapSaveBtn() {
    String whatTodo = whatToDoController.text.trim();

    List<String> imagePhats = uploadFiles.map((e) => e.path).toList();
    DiaryModel diaryModel = DiaryModel(
      dateTime: widget.selectedDay,
      fealIndex: selectedFealIndex,
      whatTodo: whatTodo,
      imagePath: imagePhats,
      weatherIconIndex: selectedWeatherIndexs,
    );

    if (widget.diaryModel != null) {
      diaryModel.id = widget.diaryModel!.id;
      diaryModel.createdAt = widget.diaryModel!.createdAt;
    }

    diaryController.insert(diaryModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: AppString.saveText.tr,
              onTap: onTapSaveBtn,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: RS.h10,
                horizontal: RS.width20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ExpansionIconCard(
                    icons: AppConstant.faceIcons,
                    label: '감정 상태',
                    isOnlyOne: true,
                    selectedIconIndexs: [],
                  ),
                  SizedBox(height: RS.h10),

                  ExpansionIconCard(
                    icons: AppConstant.zeroToNineIcons,
                    label: '통증 강도',
                    isOnlyOne: true,
                    selectedIconIndexs: [],
                  ),
                  SizedBox(height: RS.h10),

                  ColTextAndWidget(
                    label: AppString.whatDidYouHintMsg.tr,
                    widget: CustomTextFormField(
                      hintText: AppString.plzEnterTextMsg.tr,
                      controller: whatToDoController,
                      maxLines: 7,
                    ),
                  ),
                  SizedBox(height: RS.height20),
                  ImageOfToday(
                      label: '${AppString.photoOfToday.tr}',
                      uploadFiles: uploadFiles,
                      selectedPhotos: () async {
                        File file =
                            (await Get.to(() => const ImagePickerScreen()));
                        if (!uploadFiles.contains(file)) {
                          uploadFiles.add(file);
                        }
                        setState(() {}); // Dont' remove
                      },
                      removePhoto: (index) {
                        setState(() {
                          uploadFiles.removeAt(index);
                        });
                      }),
                  SizedBox(height: RS.height20),
                  CustomExpansionCard(
                    title: AppString.health.tr,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: RS.w10),
                      child: Column(
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
                  ),

                  SizedBox(height: RS.height20),
                  ExpansionIconCard(
                    icons: AppConstant.weatherIcons,
                    label: AppString.weatherText.tr,
                    selectedIconIndexs: selectedWeatherIndexs,
                  ),

                  SizedBox(height: RS.height20),
                  Container(
                    padding: EdgeInsets.all(RS.width8),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? AppColors.black : Colors.white,
                      borderRadius: BorderRadius.circular(RS.h10),
                    ),
                    child: Column(
                      children: [
                        Text(AppString.howFealToday.tr),
                        SizedBox(height: RS.h10 / 2),
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
                                    width:
                                        isSelected ? RS.w10 * 5.5 : RS.w10 * 5,
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
