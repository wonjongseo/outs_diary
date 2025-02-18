import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/c_dropdown_button.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/add_hosipital_visit_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/add_diary/widgets/image_of_today.dart';

class AddHospitalVisitLogScreen extends StatelessWidget {
  const AddHospitalVisitLogScreen({
    super.key,
    required this.selectedDate,
    this.hospitalLogModel,
  });

  final DateTime selectedDate;
  final HospitalLogModel? hospitalLogModel;
  // String? _startTime;
  @override
  Widget build(BuildContext context) {
    Get.put(AddHosipitalVisitController(
        selectedDate: selectedDate, hospitalLogModel: hospitalLogModel));
    return GetBuilder<AddHosipitalVisitController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: Text('병원 방문 기록 등록')),
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                label: AppString.saveText.tr,
                onTap: controller.saveVisitLog,
              )
            ],
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: RS.h10,
                  horizontal: RS.width20,
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.bottomSheetController?.close();
                    controller.bottomSheetController = null;
                  },
                  child: Column(
                    children: [
                      ColTextAndWidget(
                        label: '일자',
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText: controller.selectedDate == null
                                        ? '방문 날짜'
                                        : DateFormat(
                                                "MM${AppString.month.tr} d${AppString.day.tr}")
                                            .format(controller.selectedDate),
                                    readOnly: true,
                                    widget: IconButton(
                                      onPressed: () =>
                                          controller.onTapVisitDay(context),
                                      // onPressed: () async {
                                      //   DateTime? _pickerDate =
                                      //       await AppFunction.pickDate(context);

                                      //   if (_pickerDate != null) {
                                      //     controller.selectedDate = _pickerDate;
                                      //     setState(() {});
                                      //   } else {
                                      //     print('asasd');
                                      //   }
                                      // },
                                      icon: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),
                                SizedBox(width: RS.w10),
                                Expanded(
                                  child: CustomTextFormField(
                                    readOnly: true,
                                    hintText: controller.startTime ?? '방문 시간',
                                    widget: IconButton(
                                      onPressed: () =>
                                          controller.onTapVisitTime(context),
                                      // onPressed: () async {
                                      //   TimeOfDay? pickedTime =
                                      //       await showTimePicker(
                                      //     cancelText:
                                      //         AppString.cancelBtnTextTr.tr,
                                      //     helpText: '방문 시간을 입력해주세요.',
                                      //     errorInvalidText: '올바른 시간을 입력해주세요',
                                      //     hourLabelText: AppString.hour.tr,
                                      //     minuteLabelText: AppString.minute.tr,
                                      //     context: context,
                                      //     initialTime: TimeOfDay.now(),
                                      //   );
                                      //   if (pickedTime == null) {
                                      //     return;
                                      //   }
                                      //   String formatedTime =
                                      //       pickedTime.format(context);
                                      //   controller.startTime = formatedTime;
                                      //   setState(() {});
                                      // },
                                      icon: Icon(Icons.keyboard_arrow_down),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: RS.h10 * 2),
                            GestureDetector(
                              onTap: controller.onTapEnrollAlarm,
                              // onTap: () {
                              //   controller.isEnrollAlarm =
                              //       !controller.isEnrollAlarm;
                              //   setState(() {});
                              // },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '알람 등록',
                                    style: controller.isEnrollAlarm
                                        ? const TextStyle(
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.w600,
                                          )
                                        : TextStyle(),
                                  ),
                                  SizedBox(width: RS.w10),
                                  CircleAvatar(
                                    backgroundColor: controller.isEnrollAlarm
                                        ? Colors.pinkAccent
                                        : Colors.grey,
                                    radius: RS.w10 * 1.2,
                                    child: Icon(
                                      Icons.done,
                                      size: RS.w10 * 1.5,
                                      color: controller.isEnrollAlarm
                                          ? Colors.white
                                          : null,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: '병원 이름',
                        widget: CustomTextFormField(
                          controller: controller.hospitalNameCtl,
                          widget: controller.savedHospitalNames.isEmpty
                              ? null
                              : CDropdownButton(
                                  items: controller.savedHospitalNames,
                                  onChanged: (v) {
                                    controller.hospitalNameCtl.text = v;
                                  },
                                ),
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: '진료과',
                        widget: CustomTextFormField(
                          controller: controller.officeNameCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: '진단 이름',
                        widget: CustomTextFormField(
                          controller: controller.diseaseNameCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: '진단 결과',
                        widget: CustomTextFormField(
                          maxLines: 4,
                          controller: controller.diagnosisCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: '처방 받은 약물',
                        labelWidget: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: controller.addPillCtl,
                        ),
                        widget: Column(
                          children: List.generate(
                            controller.pillCtls.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: RS.h10),
                              child: CustomTextFormField(
                                controller: controller.pillCtls[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ImageOfToday(
                          carouselSliderController:
                              controller.carouselSliderController,
                          label: '진단서 혹은 처방전',
                          uploadFiles: controller.uploadFiles,
                          selectedPhotos: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(height: RS.h10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(width: RS.w10),
                                        IconButton(
                                          onPressed: controller.addPhotos,
                                          // onPressed: () async {
                                          //   Get.back();
                                          //   final ImagePicker picker =
                                          //       ImagePicker();
                                          //   final XFile? image =
                                          //       await picker.pickImage(
                                          //           source:
                                          //               ImageSource.gallery);

                                          //   if (image == null) {
                                          //     return;
                                          //   } //
                                          //   File file = File(image!.path);

                                          //   if (!controller.uploadFiles
                                          //       .contains(file)) {
                                          //     controller.uploadFiles.add(file);
                                          //   }
                                          //   setState(() {}); // Dont' remove
                                          // },
                                          icon: Icon(
                                            Icons.folder_copy_outlined,
                                            size: RS.w10 * 3,
                                          ),
                                        ),
                                        SizedBox(width: RS.w10 * 2),
                                      ],
                                    ),
                                    SizedBox(height: RS.h10 * 5),
                                  ],
                                );
                              },
                            );
                          },
                          removePhoto: (index) => controller.removePhoto(index)
                          // removePhoto: (index) {
                          //   setState(() {
                          //     controller.uploadFiles.removeAt(index);
                          //   });
                          // },
                          ),
                      SizedBox(height: RS.h10 * 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
