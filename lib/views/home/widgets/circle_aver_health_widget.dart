import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class CircleAverHealthWidget extends StatelessWidget {
  const CircleAverHealthWidget({
    super.key,
    required this.title,
    required this.averValue,
  });

  final String title;
  final double averValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(RS.w10 * .8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: RS.w10 * 1.6,
            ),
          ),
          SizedBox(width: RS.w10 * .8),
          Text(averValue.toString())
        ],
      ),
    );
  }
}
