import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/c_dropdown_button.dart';
import 'package:ours_log/common/widgets/custom_button.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/hospital_log_controller.dart';
import 'package:ours_log/models/hospital_log_model.dart';
import 'package:ours_log/respository/setting_repository.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/add_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/image_picker_screen.dart';

class AddHospitalVisitLogScreen extends StatefulWidget {
  const AddHospitalVisitLogScreen({
    super.key,
    required this.selectedDate,
    this.hospitalLogModel,
  });

  final DateTime selectedDate;
  final HospitalLogModel? hospitalLogModel;
  @override
  State<AddHospitalVisitLogScreen> createState() =>
      _AddHospitalVisitLogScreenState();
}

class _AddHospitalVisitLogScreenState extends State<AddHospitalVisitLogScreen> {
  String? _startTime;
  late DateTime _selectedDate;

  HospitalLogController hospitalLogController =
      Get.find<HospitalLogController>();

  late TextEditingController hospitalNameCtl;
  late TextEditingController officeNameCtl;
  late TextEditingController diseaseNameCtl;
  late TextEditingController diagnosisCtl;

  ScrollController scrollController = ScrollController();

  late List<TextEditingController> pillCtls = [];
  List<File> uploadFiles = [];

  @override
  void initState() {
    _selectedDate = widget.selectedDate;

    if (widget.hospitalLogModel != null) {
      _startTime = widget.hospitalLogModel!.startTime;
      hospitalNameCtl =
          TextEditingController(text: widget.hospitalLogModel!.hospitalName);
      officeNameCtl =
          TextEditingController(text: widget.hospitalLogModel!.officeName);
      diseaseNameCtl =
          TextEditingController(text: widget.hospitalLogModel!.diseaseName);
      diagnosisCtl =
          TextEditingController(text: widget.hospitalLogModel!.diagnosis);

      uploadFiles =
          widget.hospitalLogModel!.imagesPath.map((e) => File(e)).toList();

      if (widget.hospitalLogModel!.pills != null) {
        for (var pill in widget.hospitalLogModel!.pills!) {
          pillCtls.add(TextEditingController(text: pill));
        }
      }
    } else {
      hospitalNameCtl = TextEditingController();
      officeNameCtl = TextEditingController();
      diseaseNameCtl = TextEditingController();
      diagnosisCtl = TextEditingController();
      pillCtls.add(TextEditingController());
    }
    getHospitalNams();
    super.initState();
  }

  List savedHospitalNames = [];

  void getHospitalNams() async {
    savedHospitalNames =
        await SettingRepository.getList(AppConstant.hospitalNamesBox);
    setState(() {});
  }

  @override
  void dispose() {
    hospitalNameCtl.dispose();
    officeNameCtl.dispose();
    diseaseNameCtl.dispose();
    diagnosisCtl.dispose();
    for (var pillCtl in pillCtls) {
      pillCtl.dispose();
    }
    scrollController.dispose();
    super.dispose();
  }

  saveVisitLog() {
    // if (_startTime == null) {
    //   AppFunction.invaildTextFeildSnackBar(
    //       title: '필수', message: '방문 시간을 선택해주세요');
    //   scrollGoToTop();
    //   return;
    // }
    String hospitalName = hospitalNameCtl.text;

    if (hospitalName.isEmpty) {
      AppFunction.invaildTextFeildSnackBar(
          title: AppString.requiredText.tr, message: '병원 이름을 입력해주세요');
      AppFunction.scrollGoToTop(scrollController);
      return;
    }

    String officeName = officeNameCtl.text;
    String diseaseName = diseaseNameCtl.text;
    String diagnosis = diagnosisCtl.text;

    List<String> pills = pillCtls.map((e) => e.text).toList();

    List<String> imagesPath = uploadFiles.map((e) => e.path).toList();

    HospitalLogModel hospitalLogModel = HospitalLogModel(
      startTime: _startTime,
      dateTime: _selectedDate,
      hospitalName: hospitalName,
      officeName: officeName,
      diseaseName: diseaseName,
      diagnosis: diagnosis,
      imagesPath: imagesPath,
      pills: pills,
    );

    if (widget.hospitalLogModel != null) {
      hospitalLogModel.id = widget.hospitalLogModel!.id;
      hospitalLogModel.createdAt = widget.hospitalLogModel!.createdAt;
    }

    hospitalLogController.save(hospitalLogModel);
    Get.back();

    AppFunction.vaildTextFeildSnackBar(
      title: widget.hospitalLogModel == null ? '저장' : '변경',
      message: widget.hospitalLogModel == null
          ? '병원 기록이 저장 되었습니다.'
          : '병원 기록이 변경 되었습니다.',
    );
  }

  // void scrollGoToTop() {
  //   scrollController.animateTo(
  //     0,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  PersistentBottomSheetController? bottomSheetController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('병원 방문 기록 등록')),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              label: AppString.saveText.tr,
              onTap: saveVisitLog,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: RS.h10,
                horizontal: RS.width20,
              ),
              child: GestureDetector(
                onTap: () {
                  bottomSheetController?.close();
                  bottomSheetController = null;
                },
                child: Column(
                  children: [
                    ColTextAndWidget(
                      label: '일자',
                      widget: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hintText: _selectedDate == null
                                  ? '방문 날짜'
                                  : DateFormat(
                                          "MM${AppString.month.tr} d${AppString.day.tr}")
                                      .format(_selectedDate),
                              readOnly: true,
                              widget: IconButton(
                                onPressed: () async {
                                  DateTime? _pickerDate =
                                      await AppFunction.pickDate(context);

                                  // = await showDatePicker(
                                  //     context: context,
                                  //     initialDate: DateTime.now(),
                                  //     firstDate: DateTime.now().subtract(
                                  //         const Duration(days: 365 * 3)),
                                  //     lastDate: DateTime.now()
                                  //         .add(const Duration(days: 365 * 3)));

                                  if (_pickerDate != null) {
                                    _selectedDate = _pickerDate;
                                    setState(() {});
                                  } else {
                                    print('asasd');
                                  }
                                },
                                icon: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          SizedBox(width: RS.w10),
                          Expanded(
                            child: CustomTextFormField(
                              readOnly: true,
                              hintText: _startTime ?? '방문 시간',
                              widget: IconButton(
                                onPressed: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    cancelText: AppString.cancelBtnTextTr.tr,
                                    helpText: '방문 시간을 입력해주세요.',
                                    errorInvalidText: '올바른 시간을 입력해주세요',
                                    hourLabelText: AppString.hour.tr,
                                    minuteLabelText: AppString.minute.tr,
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime == null) {
                                    return;
                                  }
                                  String formatedTime =
                                      pickedTime.format(context);
                                  _startTime = formatedTime;
                                  setState(() {});
                                },
                                icon: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: '병원 이름',
                      widget: CustomTextFormField(
                        controller: hospitalNameCtl,
                        widget: savedHospitalNames.isEmpty
                            ? null
                            : CDropdownButton(
                                items: savedHospitalNames,
                                onChanged: (v) {
                                  hospitalNameCtl.text = v;
                                  setState(() {});
                                },
                              ),
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: '진료과',
                      widget: CustomTextFormField(
                        controller: officeNameCtl,
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: '진단 이름',
                      widget: CustomTextFormField(
                        controller: diseaseNameCtl,
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: '진단 결과',
                      widget: CustomTextFormField(
                        maxLines: 4,
                        controller: diagnosisCtl,
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ColTextAndWidget(
                      label: '처방 받은 약물',
                      labelWidget: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            pillCtls.add(TextEditingController());
                          });
                        },
                      ),
                      widget: Column(
                        children: List.generate(
                          pillCtls.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: RS.h10),
                            child: CustomTextFormField(
                              controller: pillCtls[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: RS.h10),
                    ImageOfToday(
                      label: '진단서 혹은 처방전',
                      uploadFiles: uploadFiles,
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
                                      onPressed: () async {
                                        Get.back();
                                        final ImagePicker picker =
                                            ImagePicker();
                                        final XFile? image =
                                            await picker.pickImage(
                                                source: ImageSource.gallery);

                                        if (image == null) {
                                          return;
                                        } //
                                        File file = File(image!.path);

                                        if (!uploadFiles.contains(file)) {
                                          uploadFiles.add(file);
                                        }
                                        setState(() {}); // Dont' remove
                                      },
                                      icon: Icon(
                                        Icons.folder_copy_outlined,
                                        size: 30,
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
                      removePhoto: (index) {
                        setState(() {
                          uploadFiles.removeAt(index);
                        });
                      },
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
  }
}
