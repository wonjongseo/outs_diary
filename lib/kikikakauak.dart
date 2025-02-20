import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';
import 'package:ours_log/views/edit_diary/widgets/image_of_today.dart';
import 'package:ours_log/views/image_picker_screen.dart';

class HospitalVisitLogBody extends StatefulWidget {
  const HospitalVisitLogBody({super.key});

  @override
  State<HospitalVisitLogBody> createState() => _HospitalVisitLogBodyState();
}

class _HospitalVisitLogBodyState extends State<HospitalVisitLogBody> {
  DateTime _selectedDateTime = DateTime.now();

  Container _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        locale: Get.locale.toString(),
        initialSelectedDate: _selectedDateTime,
        selectionColor: Colors.redAccent,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (selectedDate) {
          _selectedDateTime = selectedDate;
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Get.locale : ${Get.locale}');

    return Column(
      children: [
        _addDateBar(),
      ],
    );
  }
}
