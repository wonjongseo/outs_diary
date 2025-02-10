import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';

class HospitalVisitLogBody extends StatefulWidget {
  const HospitalVisitLogBody({super.key});

  @override
  State<HospitalVisitLogBody> createState() => _HospitalVisitLogBodyState();
}

class _HospitalVisitLogBodyState extends State<HospitalVisitLogBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColTextAndWidget(
          label: '일자',
          widget: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: '방문 날짜',
                  widget: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
              SizedBox(width: RS.w10),
              Expanded(
                child: CustomTextFormField(
                  hintText: '방문 시간',
                  widget: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: RS.h10),
        ColTextAndWidget(
          label: '방문 시간',
          widget: CustomTextFormField(),
        ),
        SizedBox(height: RS.h10)
      ],
    );
  }
}
