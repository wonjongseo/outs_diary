import 'package:flutter/material.dart';
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
        horizontal: RS.width15,
        vertical: RS.height15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.pinkAccent : Colors.grey,
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
              SizedBox(height: RS.height10 / 2),
              Text(displayArticle.description),
            ],
          ),
          SizedBox(width: RS.width20),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: List.generate(
                displayArticle.icons.length,
                (index) {
                  return Positioned(
                    right: index == 0 ? null : index * 40,
                    child: Container(
                      width: RS.width10 * 5,
                      height: RS.width10 * 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white,
                        // color: Colors.pinkAccent,
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
