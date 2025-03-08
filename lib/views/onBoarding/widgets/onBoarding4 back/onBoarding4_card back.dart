import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/onBoarding/onBoarding_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/circle_done.dart';

class OnBoarding2Card extends StatelessWidget {
  const OnBoarding2Card({
    super.key,
    required this.isSelected,
    required this.displayArticle,
  });

  final bool isSelected;
  final DisplayArticle displayArticle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleDone(isSelected: isSelected),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(displayArticle.label),
              SizedBox(height: 5),
              Text(displayArticle.description),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: List.generate(
                displayArticle.icons.length,
                (index) {
                  return Positioned(
                    right: index == 0 ? null : index * 40,
                    child: Container(
                      width: 10 * 5,
                      height: 10 * 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!),
                        color: AppColors.white,
                        // color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Icon(displayArticle.icons[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
