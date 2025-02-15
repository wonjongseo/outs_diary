import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/add_diary_controller.dart';
import 'package:ours_log/views/add_diary/widgets/col_text_and_widget.dart';

class InputPeriod extends StatelessWidget {
  const InputPeriod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDiaryController>(builder: (controller) {
      return ColTextAndWidget(
        label: '마법의 날',
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.w10 * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('생리 시작'),
                  Checkbox(
                    value: controller.startMasicDay != null ||
                        controller.isStartedMasic != null,
                    onChanged: (v) => controller.toggleMagicDay(true),
                  )
                ],
              ),
              Column(
                children: [
                  Text('생리 끝'),
                  Checkbox(
                    value: controller.endMasicDay != null ||
                            controller.isEndedMasic != null
                        ? true
                        : false,
                    onChanged: (v) => controller.toggleMagicDay(false),
                  )
                ],
              ),
            ],
          ),
        ),
        // widget: Row(
        //   children: [
        //     Expanded(
        //       child: CustomTextFormField(
        //           readOnly: true,
        //           hintText: addDiaryController.startMasicDay == null
        //               ? '시작 일'
        //               : DateFormat('M월d일').format(
        //                   addDiaryController.startMasicDay!,
        //                 ),
        //           onTap: () async {
        //             addDiaryController.selectDate(
        //               context,
        //               isStartDate: true,
        //             );
        //           }),
        //     ),
        //     SizedBox(width: RS.w10),
        //     Expanded(
        //       child: CustomTextFormField(
        //         readOnly: true,
        //         hintText: addDiaryController.endMasicDay == null
        //             ? '마지막 일'
        //             : DateFormat('M일d월').format(
        //                 addDiaryController.endMasicDay!,
        //               ),
        //         onTap: () {
        //           addDiaryController.selectDate(
        //             context,
        //             isEndDate: true,
        //             firstDate: addDiaryController.startMasicDay,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      );
    });
  }
}
