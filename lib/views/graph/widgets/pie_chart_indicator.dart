import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class PieChartIndicator extends StatelessWidget {
  const PieChartIndicator({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: RS.h10 * .8,
          backgroundColor: color,
        ),
        SizedBox(width: RS.w10),
        Text(text)
      ],
    );
  }
}
