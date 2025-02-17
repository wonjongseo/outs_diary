import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/onboarding_controller.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/setting/widgets/background1_sample.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.8,
            fontWeight: FontWeight.bold,
            fontSize: RS.width18,
          ),
          TextSpan(
            text: AppString.selectBackgroundMsg.tr,
          ),
        ),
        SizedBox(height: RS.h10),
        GetBuilder<OnboardingController>(builder: (backgroundController) {
          return Stack(
            children: [
              CarouselSlider(
                items:
                    List.generate(AppConstant.backgroundLists.length, (index) {
                  return GestureDetector(
                    onTap: () => backgroundController.setBackgroundIndex(index),
                    child: Stack(
                      children: [
                        BackGround1Sample(
                          backgrounds:
                              AppConstant.backgroundLists[index].images,
                          isSelected:
                              backgroundController.backgroundIndex == index,
                        ),
                        Container(
                          margin: EdgeInsets.all(RS.w10 * 1.5),
                          width: RS.w10 * 3,
                          height: RS.w10 * 3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: backgroundController.backgroundIndex == index
                                ? Colors.pinkAccent
                                : Colors.grey,
                          ),
                          child: backgroundController.backgroundIndex == index
                              ? Icon(
                                  Icons.check,
                                  size: RS.w10 * 2,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Text(
                                  AppConstant
                                      .backgroundLists[index].description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RS.w10 * 2.2,
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                AppConstant.backgroundLists[index].description,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RS.w10 * 2.2,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
                options: CarouselOptions(
                  height: 550,
                  viewportFraction: 0.8,
                  initialPage: backgroundController.backgroundIndex,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        })
      ],
    );
  }
}
