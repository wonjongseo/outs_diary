import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/feal_icon_row.dart';
import 'package:ours_log/controller/user_controller.dart';

class SetFealIconScreen extends StatelessWidget {
  const SetFealIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<UserController>(builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: RS.w10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                AppConstant.fealIconLists.length,
                (index) {
                  bool isSelected = controller.fealIconIndex == index;
                  return GestureDetector(
                    onTap: () => controller.setFealIconIndex(index),
                    child: FealIconRow(
                      isSelected: isSelected,
                      fealIcon: AppConstant.fealIconLists[index],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
