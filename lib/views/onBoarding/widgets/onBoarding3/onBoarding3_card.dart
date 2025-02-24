import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/views/onBoarding/onBoarding_screen.dart';
import 'package:ours_log/views/onBoarding/widgets/circle_done.dart';

class OnBoarding3Card extends StatelessWidget {
  const OnBoarding3Card({
    super.key,
    required this.isSelected,
    required this.displayArticle,
    required this.icons,
  });

  final bool isSelected;
  final DisplayArticle displayArticle;
  final List<String> icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.width15,
        vertical: RS.height15,
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
          SizedBox(width: RS.width15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(displayArticle.label),
              SizedBox(height: RS.h5),
              Text(displayArticle.description),
            ],
          ),
          SizedBox(width: RS.width20),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: List.generate(
                icons.length,
                (index) {
                  return Positioned(
                    right: index == 0 ? null : index * 40,
                    child: Container(
                      width: RS.w10 * 5,
                      height: RS.w10 * 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!),
                        color: AppColors.white,
                        // color: AppColors.primaryColor,
                      ),
                      child: Center(
                          child: Image.asset(
                        icons[index],
                        width: isSelected ? RS.w10 * 6 : RS.w10 * 5,
                        height: isSelected ? RS.w10 * 6 : RS.w10 * 5,
                      )),
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
