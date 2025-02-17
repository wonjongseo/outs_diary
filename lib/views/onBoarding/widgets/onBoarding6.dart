import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_text_form_field.dart';
import 'package:ours_log/controller/user_controller.dart';

class Onboarding6 extends StatelessWidget {
  Onboarding6({super.key, required this.isShownMLE, required this.isShownDays});

  final bool isShownMLE;
  final bool isShownDays;

  var textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: RS.w10 * 1.8,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FadeInRight(
            child: Column(
              children: [
                Text(
                  '어떤 약을 복용하고 계신가요?',
                  style: textStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.w10 * 3.5,
                    vertical: RS.h10,
                  ),
                  child: CustomTextFormField(
                      controller: userController.teCrl,
                      hintText: 'ex) 아침 약',
                      onFieldSubmitted: (v) {}),
                ),
              ],
            ),
          ),
          // SizedBox(height: RS.h10 * 2),
          if (isShownMLE)
            FadeInRight(
              child: Column(
                children: [
                  Text('하루에 몇번 드시고 계신가요?', style: textStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: RS.h10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          List.generate(morningLunchEvening.length, (index) {
                        // bool isSelected = userController
                        //     .selectedMorningLunchEvening
                        //     .contains(index);
                        return GestureDetector(
                          onTap: () => userController.aa(index),
                          child: Container(
                            width: RS.w10 * 10,
                            height: RS.w10 * 10,
                            margin:
                                EdgeInsets.symmetric(horizontal: RS.w10 / 2),
                            decoration: BoxDecoration(
                                border: userController
                                        .selectedMorningLunchEvening
                                        .contains(index)
                                    ? Border.all(
                                        color: Colors.pinkAccent, width: 2)
                                    : Border.all(color: Colors.grey, width: 1),
                                borderRadius:
                                    BorderRadius.circular(RS.w10 * 2.5)),
                            child: Center(
                              child: Text(morningLunchEvening[index]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          // SizedBox(height: RS.h10 * 2),

          if (isShownDays)
            FadeInRight(
              child: Column(
                children: [
                  Text('어떤 요일에 복용하고 계신가요?', style: textStyle),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: RS.h10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(dayKo.length, (index) {
                          // bool isSelected =
                          //     userController.selectedDays.contains(index);
                          return GestureDetector(
                            onTap: () => userController.bb(index),
                            // onTap: () {
                            //   setState(() {
                            //     if (isSelected) {
                            //       userController.selectedDays.remove(index);
                            //     } else {
                            //       userController.selectedDays.add(index);
                            //     }
                            //   });
                            // },
                            child: Container(
                              width: RS.w10 * 8,
                              height: RS.w10 * 10,
                              margin:
                                  EdgeInsets.symmetric(horizontal: RS.w10 / 2),
                              decoration: BoxDecoration(
                                  border: userController.selectedDays
                                          .contains(index)
                                      ? Border.all(
                                          color: Colors.pinkAccent, width: 2)
                                      : Border.all(
                                          color: Colors.grey, width: 1),
                                  borderRadius:
                                      BorderRadius.circular(RS.w10 * 1.5)),
                              child: Center(
                                child: Text(dayKo[index]),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      );
    });
  }
}

List<String> morningLunchEvening = ['아침', '점심', '저녁'];
List<String> dayKo = ['월', '화', '수', '목', '금', '토', '일'];
