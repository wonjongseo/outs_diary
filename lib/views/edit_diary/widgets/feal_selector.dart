import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/string/app_string.dart';

import 'package:ours_log/controller/edit_diary_controller.dart';

class FealSelector extends StatelessWidget {
  const FealSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDiaryController>(builder: (addDiaryController) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(AppString.howFealToday.tr),
            const SizedBox(height: 5),
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
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(.2),
                        radius: isSelected ? 10 * 2.5 : 10 * 2,
                        child: Image.asset(
                          addDiaryController.userController.feals[index],
                          colorBlendMode: BlendMode.modulate,
                          color: isSelected
                              ? null
                              : AppColors.white.withOpacity(.7),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "← ${AppString.veryGood.tr}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    "${AppString.veryBad.tr}→",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
