import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ours_log/common/enums/gender_type.dart';
import 'package:ours_log/common/utilities/app_string.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({
    Key? key,
    this.genderType,
    required this.streamConsumer,
  }) : super(key: key);

  final GenderType? genderType;
  final StreamController streamConsumer;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            text: '무엇을 기록할지 고르기 전,\n먼저 성별을 알려주세요.\n',
            children: [
              TextSpan(
                text: '알려주신 정보에 맞춰 기록 블럭을 추천해드릴게요.',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: RS.width16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: RS.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                streamConsumer.sink.add(GenderType.MAIL);
              },
              child: Container(
                width: size.width / 3 - 30,
                height: size.width / 3 - 30,
                decoration: BoxDecoration(
                  color:
                      genderType == GenderType.MAIL ? Colors.pinkAccent : null,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.mars),
                      SizedBox(height: RS.h10),
                      Text(AppString.male.tr),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: RS.width20),
            GestureDetector(
              onTap: () {
                streamConsumer.sink.add(GenderType.FEMAIL);
              },
              child: Container(
                width: size.width / 3 - 30,
                height: size.width / 3 - 30,
                decoration: BoxDecoration(
                  color: genderType == GenderType.FEMAIL
                      ? Colors.pinkAccent
                      : null,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.venus),
                      SizedBox(height: RS.h10),
                      Text(AppString.female.tr),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: RS.width20),
            GestureDetector(
              onTap: () {
                streamConsumer.sink.add(GenderType.ANOTHER);
              },
              child: Container(
                width: size.width / 3 - 30,
                height: size.width / 3 - 30,
                decoration: BoxDecoration(
                  color: genderType == GenderType.ANOTHER
                      ? Colors.pinkAccent
                      : null,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.marsAndVenus),
                      SizedBox(height: RS.h10),
                      Text(AppString.another.tr),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
