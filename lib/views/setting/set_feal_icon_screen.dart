import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/admob/global_banner_admob.dart';
import 'package:ours_log/common/utilities/app_constant.dart';

import 'package:ours_log/common/widgets/feal_icon_row.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/background/background_widget.dart';

class SetFealIconScreen extends StatelessWidget {
  const SetFealIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [GlobalBannerAdmob()],
        ),
      ),
      body: BackgroundWidget(
        child: SafeArea(
          child: GetBuilder<UserController>(builder: (controller) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  AppConstant.fealIconLists.length,
                  (index) {
                    bool isSelected =
                        controller.userModel?.fealIconIndex == index;
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
      ),
    );
  }
}
