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
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 8),
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
