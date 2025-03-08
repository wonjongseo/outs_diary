import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class DoneCircleIcon extends StatelessWidget {
  const DoneCircleIcon({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.width,
  });

  final String label;
  final Color backgroundColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: width ?? 10 * 9),
      // width: width ?? 10 * 9,
      height: 10 * 4,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            radius: 10 * 1.2,
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 10 * 2,
            ),
          ),
          SizedBox(width: 10),
          Text(label)
        ],
      ),
    );
  }
}
