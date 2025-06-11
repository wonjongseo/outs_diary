import 'package:flutter/material.dart';
import 'package:ours_log/common/utilities/app_color.dart';

class DoneCircleIcon extends StatelessWidget {
  const DoneCircleIcon({
    super.key,
    required this.label,
    required this.isDone,
    this.width,
  });

  final String label;
  final bool isDone;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: width ?? 80),
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: isDone ? AppColors.primaryColor : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: isDone ? AppColors.primaryColor : Colors.grey,
            radius: 12,
            child: isDone
                ? const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(label)
        ],
      ),
    );
  }
}
