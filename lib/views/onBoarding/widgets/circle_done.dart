import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class CircleDone extends StatelessWidget {
  const CircleDone({super.key, required this.isSelected});

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: RS.w10 * 3,
      height: RS.w10 * 3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.pinkAccent : Colors.grey,
      ),
      child: Center(
        child: Icon(Icons.done),
      ),
    );
  }
}
