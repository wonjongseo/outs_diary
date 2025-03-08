import 'package:ours_log/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class CircleDone extends StatelessWidget {
  const CircleDone({super.key, required this.isSelected});

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10 * 3,
      height: 10 * 3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.primaryColor : Colors.grey,
      ),
      child: Center(
        child: Icon(Icons.done),
      ),
    );
  }
}
