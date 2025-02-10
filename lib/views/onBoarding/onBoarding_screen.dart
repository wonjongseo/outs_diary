import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:ours_log/common/enums/gender_type.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/onBoarding/widgets/circle_done.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding1/onBoarding1.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding2/onBoarding2.dart';

class DisplayArticle {
  final String label;
  final String description;
  List<IconData> icons;
  DisplayArticle({
    required this.label,
    required this.description,
    required this.icons,
  });
}

List<DisplayArticle> displayArticles = [
  DisplayArticle(label: '감성', description: '1', icons: [
    Icons.heat_pump,
    Icons.heat_pump,
    Icons.heat_pump,
  ]),
  DisplayArticle(label: '2', description: '2', icons: [
    Icons.heat_pump,
    Icons.heat_pump,
    Icons.heat_pump,
  ]),
  DisplayArticle(label: '3', description: '3', icons: [
    Icons.heat_pump,
    Icons.heat_pump,
    Icons.heat_pump,
  ]),
  DisplayArticle(label: '4', description: '4', icons: [
    Icons.heat_pump,
    Icons.heat_pump,
    Icons.heat_pump,
  ]),
  DisplayArticle(label: '5', description: '5', icons: [
    Icons.heat_pump,
    Icons.heat_pump,
    Icons.heat_pump,
  ]),
];

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  GenderType? genderType; // on board 1
  List<int> selectedIndex = []; // on board 2
  bool isSelected = false;
  int pageIndex = 0;
  late PageController pageController;

  Duration pageDuration = const Duration(milliseconds: 180);
  Curve pageCurves = Curves.linear;
  StreamController onBoarding1StreamController = StreamController();
  StreamController onBoarding2StreamController = StreamController();

  List<Widget> bodys = [];
  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex);

    setStreamController();

    super.initState();
  }

  void setStreamController() {
    onBoarding1StreamController.stream.listen((event) {
      setState(() {
        genderType = event;
      });
    });
    onBoarding2StreamController.stream.listen(
      (index) {
        setState(() {
          if (selectedIndex.contains(index)) {
            selectedIndex.remove(index);
          } else {
            selectedIndex.add(index);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: RS.h10,
              horizontal: RS.w10,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    itemBuilder: (context, index) {
                      // return Column(
                      //   children: [
                      //     Text.rich(
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //         height: 1.8,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: RS.width18,
                      //       ),
                      //       TextSpan(
                      //         text: '스페셜 블럭을 추가할까요?\n',
                      //         children: [
                      //           TextSpan(
                      //             text: '맞춤형 기록과 특별한 분석이 함께해요.',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: RS.width16,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(height: RS.height20),
                      //     Container(
                      //       padding: EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //         color: Get.isDarkMode
                      //             ? AppColors.backgroundDark
                      //             : Colors.white,
                      //         borderRadius: BorderRadius.circular(RS.height10),
                      //       ),
                      //       child: Column(
                      //         children: [
                      //           Row(
                      //             children: [
                      //               CircleDone(isSelected: isSelected),
                      //               SizedBox(width: RS.width20),
                      //               Text('수면 기록')
                      //             ],
                      //           ),
                      //           Text('7시 40분'),
                      //           Container()
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // );

                      switch (index) {
                        case 0:
                          return OnBoarding1(
                            genderType: genderType,
                            streamConsumer: onBoarding1StreamController,
                          );
                        case 1:
                          return OnBoarding2(
                            selectedIndex: selectedIndex,
                            streamController: onBoarding2StreamController,
                          );
                        default:
                          return Column(
                            children: [
                              Text(genderType == null
                                  ? " NO "
                                  : genderType!.name),
                              Text(selectedIndex.length.toString()),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _nextBtn(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: backToPage,
            child: Text(AppString.back.tr),
          ),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              value: .2,
              color: Colors.pinkAccent,
            ),
          ),
          TextButton(
            onPressed: skipPage,
            child: Text('SKIP'),
          ),
        ],
      ),
    );
  }

  void skipPage() {
    switch (pageIndex) {
      case 0:
        genderType = null;
        break;
      case 1:
        selectedIndex = [];
        break;
    }
    goToNextPage();
  }

  void backToPage() {
    pageController.previousPage(
      duration: pageDuration,
      curve: pageCurves,
    );
  }

  Widget _nextBtn() {
    return SafeArea(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: goToNextPage,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: RS.w10),
          height: RS.h10 * 6,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              AppString.next.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: RS.width20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: pageDuration,
      curve: pageCurves,
    );
  }
}
