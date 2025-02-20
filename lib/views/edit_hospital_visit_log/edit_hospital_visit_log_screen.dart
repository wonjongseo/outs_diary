import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/c_dropdown_button.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/add_hosipital_visit_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/hospital_visit_log/widgets/visit_day_and_time.dart';

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
    Get.put(EditHosipitalVisitController(
        selectedDate: selectedDate, hospitalLogModel: hospitalLogModel));
    return GetBuilder<EditHosipitalVisitController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(title: Text(AppString.enrollVisitHospitalLog.tr)),
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
                      const VisitDayAndTime(),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.hospitalName.tr,
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
                        label: AppString.officeName.tr,
                        widget: CustomTextFormField(
                          controller: controller.officeNameCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.diseaseName.tr,
                        widget: CustomTextFormField(
                          controller: controller.diseaseNameCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.diagnosis.tr,
                        widget: CustomTextFormField(
                          maxLines: 4,
                          controller: controller.diagnosisCtl,
                        ),
                      ),
                      SizedBox(height: RS.h10),
                      ColTextAndWidget(
                        label: AppString.prescribedMedicine.tr,
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
                          label: AppString.medicalCertificateOrPrescription.tr,
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
