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
      constraints: BoxConstraints(minWidth: width ?? RS.w10 * 9),
      // width: width ?? RS.w10 * 9,
      height: RS.h10 * 4,
      padding: EdgeInsets.symmetric(horizontal: RS.w10),
      margin: EdgeInsets.symmetric(horizontal: RS.w10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(RS.w10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            radius: RS.w10 * 1.2,
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: RS.w10 * 2,
            ),
          ),
          SizedBox(width: RS.w10),
          Text(label)
        ],
      ),
    );
  }
}
