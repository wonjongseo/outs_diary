import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class PieChartIndicator extends StatelessWidget {
  const PieChartIndicator({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 10 * .8,
            backgroundColor: color,
          ),
          SizedBox(width: 10),
          Text(text)
        ],
      ),
    );
  }
}
