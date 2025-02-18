import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ours_log/common/utilities/app_constant.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/controller/user_controller.dart';
import 'package:ours_log/views/background/background_widget.dart';
import 'package:ours_log/views/setting/widgets/background1_sample.dart';

class SetBackgroundScreen extends StatelessWidget {
  const SetBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController backgroundController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withValues(alpha: .2),
      ),
      body: BackgroundWidget(
        widget: SafeArea(
          child: Stack(
            children: [
              Container(color: Colors.grey.withValues(alpha: .2)),
              CarouselSlider(
                items:
                    List.generate(AppConstant.backgroundLists.length, (index) {
                  return GetBuilder<UserController>(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () =>
                            backgroundController.setBackgroundIndex(index),
                        child: Stack(
                          children: [
                            BackGround1Sample(
                              backgrounds:
                                  AppConstant.backgroundLists[index].images,
                              isSelected: backgroundController
                                      .userModel?.backgroundIndex ==
                                  index,
                            ),
                            Container(
                              margin: EdgeInsets.all(RS.w10 * 1.5),
                              width: RS.w10 * 3,
                              height: RS.w10 * 3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: backgroundController
                                            .userModel?.backgroundIndex ==
                                        index
                                    ? Colors.pinkAccent
                                    : Colors.grey,
                              ),
                              child: backgroundController
                                          .userModel?.backgroundIndex ==
                                      index
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
                                    AppConstant
                                        .backgroundLists[index].description,
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
                    },
                  );
                }),
                options: CarouselOptions(
                  height: 570,
                  viewportFraction: 0.8,
                  initialPage:
                      backgroundController.userModel?.backgroundIndex ?? 0,
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
          ),
        ),
      ),
    );
  }
}
