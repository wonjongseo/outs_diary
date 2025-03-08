import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';

class CircleAverHealthWidget extends StatelessWidget {
  const CircleAverHealthWidget({
    super.key,
    required this.title,
    required this.averValue,
  });

  final String title;
  final String averValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 10 * 10,
        ),
        padding: EdgeInsets.all(10 * .8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 10 * 1.4),
            ),
            SizedBox(width: 10 * .8),
            Text(
              averValue,
              style: TextStyle(fontSize: 10 * 1.4),
            )
          ],
        ),
      ),
    );
  }
}
