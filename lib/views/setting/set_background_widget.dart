import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/background_controller.dart';
import 'package:ours_log/views/background/background2.dart';
import 'package:ours_log/views/setting/widgets/background1_sample.dart';

class SetBackgroundScreen extends StatelessWidget {
  const SetBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BackgroundController backgroundController =
        Get.find<BackgroundController>();
    return Scaffold(
      // backgroundColor: Colors.grey.withValues(alpha: .2),
      appBar: AppBar(
        backgroundColor: Colors.grey.withValues(alpha: .2),
      ),
      body: BackGround2(
        widget: SafeArea(
          child: Stack(
            children: [
              Container(color: Colors.grey.withValues(alpha: .2)),
              CarouselSlider(
                  items: List.generate(backgroundController.backgroundss.length,
                      (index) {
                    return GetBuilder<BackgroundController>(
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              BackGround1Sample(
                                backgrounds:
                                    backgroundController.backgroundss[index],
                                isSelected:
                                    backgroundController.backgroundIndex ==
                                        index,
                              ),
                              InkWell(
                                onTap: () => backgroundController
                                    .setBackgroundIndex(index),
                                child: Container(
                                  margin: EdgeInsets.all(RS.w10 * .8),
                                  width: RS.w10 * 2.5,
                                  height: RS.w10 * 2.5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        backgroundController.backgroundIndex ==
                                                index
                                            ? Colors.pinkAccent
                                            : Colors.grey,
                                  ),
                                  child: backgroundController.backgroundIndex ==
                                          index
                                      ? Icon(
                                          Icons.check,
                                          size: RS.w10 * 1.5,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                  options: CarouselOptions(
                    height: 500,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    // autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
              if (1 == 2)
                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          backgroundController.backgroundss.length, (index) {
                        return GetBuilder<BackgroundController>(
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  BackGround1Sample(
                                    backgrounds: backgroundController
                                        .backgroundss[index],
                                    isSelected:
                                        backgroundController.backgroundIndex ==
                                            index,
                                  ),
                                  InkWell(
                                    onTap: () => backgroundController
                                        .setBackgroundIndex(index),
                                    child: Container(
                                      margin: EdgeInsets.all(RS.w10 * .8),
                                      width: RS.w10 * 2.5,
                                      height: RS.w10 * 2.5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: backgroundController
                                                    .backgroundIndex ==
                                                index
                                            ? Colors.pinkAccent
                                            : Colors.grey,
                                      ),
                                      child: backgroundController
                                                  .backgroundIndex ==
                                              index
                                          ? Icon(
                                              Icons.check,
                                              size: RS.w10 * 1.5,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
