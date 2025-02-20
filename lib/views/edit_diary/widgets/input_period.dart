import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/add_diary_controller.dart';
import 'package:ours_log/views/edit_diary/widgets/col_text_and_widget.dart';

class InputPeriod extends StatelessWidget {
  const InputPeriod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiaryController>(builder: (controller) {
      return ColTextAndWidget(
        label: '생리',
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.w10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: true
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withValues(alpha: .5),
                  foregroundColor: true ? Colors.white : Colors.grey,
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.w10 * 5,
                    vertical: RS.h10,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  '시작',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: RS.w10 * 1.8,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.w10 * 5,
                    vertical: RS.h10,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  ' 끝 ',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: RS.w10 * 1.8,
                  ),
                ),
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
