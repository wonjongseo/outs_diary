import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/responsive.dart';

class DoneCircleIcon extends StatelessWidget {
  const DoneCircleIcon({
    super.key,
    required this.label,
    required this.backgroundColor,
  });

  final String label;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: RS.w10 * 9,
      height: RS.h10 * 4,
      // padding: EdgeInsets.symmetric(
      //   vertical: RS.h10 * .8,
      //   horizontal: RS.w10 * 1.5,
      // ),
      margin: EdgeInsets.symmetric(horizontal: RS.w10 * .5),
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
