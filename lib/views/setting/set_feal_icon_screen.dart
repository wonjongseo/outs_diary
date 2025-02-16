import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/background_controller.dart';

class SetFealIconScreen extends StatelessWidget {
  const SetFealIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<BackgroundController>(builder: (controller) {
          print('controller.fealIconIndex : ${controller.fealIconIndex}');

          return Container(
            margin: EdgeInsets.symmetric(horizontal: RS.w10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                controller.fealss.length,
                (index) {
                  bool isSelected = controller.fealIconIndex == index;
                  return GestureDetector(
                    onTap: () {
                      controller.setFealIconIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(RS.w10 * .8),
                      height: RS.h10 * 7,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.pinkAccent : Colors.grey,
                          width: isSelected ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(RS.h10 * 4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.fealss[index].length,
                          (index2) => Padding(
                            padding: EdgeInsets.all(RS.w10 * .8),
                            child: Image.asset(
                              controller.fealss[index][index2],
                              width: isSelected ? RS.w10 * 5.5 : RS.w10 * 5,
                              height: isSelected ? RS.w10 * 5.5 : RS.w10 * 5,
                            ),
                          ),
                        ),
                      ),
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
