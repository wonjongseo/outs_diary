import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';

class AddHealthScreen extends StatefulWidget {
  const AddHealthScreen({super.key, required this.selectedDay});

  final DateTime selectedDay;
  @override
  State<AddHealthScreen> createState() => _AddHealthScreenState();
}

class _AddHealthScreenState extends State<AddHealthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(''),
                ColTextAndWidget(
                  label: AppString.temperature.tr,
                  widget: Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: '朝',
                        ),
                      ),
                      SizedBox(width: RS.width20),
                      Expanded(child: CustomTextFormField(hintText: '夕')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
