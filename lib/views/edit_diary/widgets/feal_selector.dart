import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/edit_diary_controller.dart';

class FealSelector extends StatelessWidget {
  const FealSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiaryController>(builder: (addDiaryController) {
      return Container(
        padding: EdgeInsets.all(RS.width8),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(RS.h10),
        ),
        child: Column(
          children: [
            Text(AppString.howFealToday.tr),
            SizedBox(height: RS.h10 / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                addDiaryController.userController.feals.length,
                (index) {
                  bool isSelected =
                      addDiaryController.selectedFealIndex == index;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => addDiaryController.onTapFealIcon(index),
                      child: Image.asset(
                        addDiaryController.userController.feals[index],
                        width: isSelected ? RS.w10 * 5.5 : RS.w10 * 4.8,
                        colorBlendMode: BlendMode.modulate,
                        color:
                            isSelected ? null : AppColors.white.withOpacity(.7),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
