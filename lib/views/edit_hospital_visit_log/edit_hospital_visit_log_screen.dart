import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/admob/global_banner_admob.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/c_dropdown_button.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/edit_hosipital_visit_controller.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/views/background/background_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/edit_hospital_visit_log/widgets/visit_day_and_time.dart';

class EditHospitalVisitLogScreen extends StatefulWidget {
  const EditHospitalVisitLogScreen({
    super.key,
    required this.selectedDate,
    this.hospitalLogModel,
  });

  final DateTime selectedDate;
  final HospitalLogModel? hospitalLogModel;

  @override
  State<EditHospitalVisitLogScreen> createState() =>
      _EditHospitalVisitLogScreenState();
}

class _EditHospitalVisitLogScreenState
    extends State<EditHospitalVisitLogScreen> {
  bool isEdit = true;

  @override
  void initState() {
    if (widget.hospitalLogModel != null) {
      isEdit = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditHosipitalVisitController editHosipitalVisitController = Get.put(
      EditHosipitalVisitController(
          selectedDate: widget.selectedDate,
          hospitalLogModel: widget.hospitalLogModel),
    );

    return GetBuilder<EditHosipitalVisitController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppString.enrollVisitHospitalLog.tr),
          centerTitle: true,
          actions: [
            if (!isEdit) ...[
              IconButton(
                  onPressed: () {
                    AppFunction.scrollGoToTop(
                        editHosipitalVisitController.scrollController);
                    setState(() => isEdit = true);
                  },
                  icon: const Icon(FontAwesomeIcons.pen)),
            ],
            if (widget.hospitalLogModel != null) ...[
              if (isEdit)
                IconButton(
                  onPressed: () => setState(() => isEdit = false),
                  icon: const Icon(FontAwesomeIcons.remove),
                ),
              IconButton(
                  onPressed: () async {
                    await Get.find<UserController>()
                        .deleteTaskFromNotificationList(
                            widget.hospitalLogModel!.notifications);
                    Get.find<HospitalLogController>()
                        .delete(widget.hospitalLogModel!);
                    Get.back();
                  },
                  icon: const Icon(FontAwesomeIcons.trashCan))
            ]
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isEdit)
                CustomButton(
                  label: AppString.saveText.tr,
                  onTap: controller.saveVisitLog,
                ),
              const GlobalBannerAdmob()
            ],
          ),
        ),
        body: BackgroundWidget(
          child: SafeArea(
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
                    onTap: isEdit
                        ? () {
                            controller.bottomSheetController?.close();
                            controller.bottomSheetController = null;
                          }
                        : null,
                    child: Column(
                      children: [
                        VisitDayAndTime(isEdit: isEdit),
                        SizedBox(height: RS.h10),
                        _hospitalName(controller),
                        SizedBox(height: RS.h10),
                        _officeName(controller),
                        SizedBox(height: RS.h10),
                        _diseaseName(controller),
                        SizedBox(height: RS.h10),
                        ColTextAndWidget(
                          label: AppString.diagnosis.tr,
                          widget: CustomTextFormField(
                            readOnly: !isEdit,
                            maxLines: 4,
                            controller: controller.diagnosisCtl,
                          ),
                        ),
                        SizedBox(height: RS.h10),
                        ColTextAndWidget(
                          label: AppString.prescribedMedicine.tr,
                          labelWidget: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: isEdit ? controller.addPillCtl : null,
                          ),
                          widget: Column(
                            children: List.generate(
                              controller.pillCtls.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(bottom: RS.h10),
                                child: CustomTextFormField(
                                  readOnly: !isEdit,
                                  controller: controller.pillCtls[index],
                                  widget: controller.savedPillNames.isEmpty
                                      ? null
                                      : CDropdownButton(
                                          items: controller.savedPillNames,
                                          onChanged: isEdit
                                              ? (v) => controller
                                                  .pillCtls[index].text = v
                                              : null,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: RS.h10),
                        ImageOfToday(
                            carouselSliderController:
                                controller.carouselSliderController,
                            label:
                                AppString.medicalCertificateOrPrescription.tr,
                            uploadFiles: controller.uploadFiles,
                            selectedPhotos: isEdit
                                ? () async {
                                    AppFunction.openCameraOrLibarySheet(
                                        context: context,
                                        takePictureFunc: () {},
                                        openLibaryFunc: controller.addPhotos);
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return Column(
                                    //       mainAxisSize: MainAxisSize.min,
                                    //       children: [
                                    //         Container(
                                    //           margin: EdgeInsets.only(top: 10),
                                    //           width: 100,
                                    //           height: 5,
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.grey,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10),
                                    //           ),
                                    //         ),
                                    //         SizedBox(height: RS.h10),
                                    //         Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.end,
                                    //           children: [
                                    //             IconButton(
                                    //               onPressed: () {},
                                    //               icon: Icon(
                                    //                 Icons.camera_alt_outlined,
                                    //                 size: 30,
                                    //               ),
                                    //             ),
                                    //             SizedBox(width: RS.w10),
                                    //             IconButton(
                                    //               onPressed: controller.addPhotos,
                                    //               icon: Icon(
                                    //                 Icons.folder_copy_outlined,
                                    //                 size: RS.w10 * 3,
                                    //               ),
                                    //             ),
                                    //             SizedBox(width: RS.w10 * 2),
                                    //           ],
                                    //         ),
                                    //         SizedBox(height: RS.h10 * 5),
                                    //       ],
                                    //     );
                                    //   },
                                    // );
                                  }
                                : null,
                            removePhoto: (index) =>
                                controller.removePhoto(index)),
                        SizedBox(height: RS.h10 * 2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  ColTextAndWidget _hospitalName(EditHosipitalVisitController controller) {
    return ColTextAndWidget(
      label: AppString.hospitalName.tr,
      widget: CustomTextFormField(
        readOnly: !isEdit,
        controller: controller.hospitalNameCtl,
        widget: controller.savedHospitalNames.isEmpty
            ? null
            : CDropdownButton(
                items: controller.savedHospitalNames,
                onChanged:
                    isEdit ? (v) => controller.hospitalNameCtl.text = v : null,
              ),
      ),
    );
  }

  ColTextAndWidget _diseaseName(EditHosipitalVisitController controller) {
    return ColTextAndWidget(
      label: AppString.diseaseName.tr,
      widget: CustomTextFormField(
        readOnly: !isEdit,
        controller: controller.diseaseNameCtl,
        widget: controller.savedDiseaseNames.isEmpty
            ? null
            : CDropdownButton(
                items: controller.savedDiseaseNames,
                onChanged:
                    isEdit ? (v) => controller.diseaseNameCtl.text = v : null,
              ),
      ),
    );
  }

  ColTextAndWidget _officeName(EditHosipitalVisitController controller) {
    return ColTextAndWidget(
      label: AppString.officeName.tr,
      widget: CustomTextFormField(
        readOnly: !isEdit,
        controller: controller.officeNameCtl,
        widget: controller.savedOfficeNames.isEmpty
            ? null
            : CDropdownButton(
                items: controller.savedOfficeNames,
                onChanged:
                    isEdit ? (v) => controller.officeNameCtl.text = v : null,
              ),
      ),
    );
  }
}
