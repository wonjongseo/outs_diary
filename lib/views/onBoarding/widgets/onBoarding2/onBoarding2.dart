import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ours_log/common/utilities/app_function.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/onBoarding/onBoarding_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/onBoarding2/onBoarding2_card.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({
    Key? key,
    required this.selectedIndex,
    required this.streamController,
  }) : super(key: key);

  final List<int> selectedIndex;
  final StreamController streamController;

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
            text: isKo ? '어떤 기록을 담아볼까요?' : 'どんな記録を入れますか？',
          ),
        ),
        SizedBox(height: RS.h10),
        Column(
          children: List.generate(
            displayArticles.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: RS.height15),
              child: GestureDetector(
                onTap: () => streamController.sink.add(index),
                child: OnBoarding2Card(
                  displayArticle: displayArticles[index],
                  isSelected: selectedIndex.contains(index),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
