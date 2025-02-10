import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:ours_log/common/enums/icon_and_index.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';

class ExpansionIconCard extends StatefulWidget {
  const ExpansionIconCard({
    super.key,
    required this.icons,
    required this.label,
    required this.selectedIconIndexs,
    this.isOnlyOne = false,
  });

  final List<IconAndIndex> icons;
  final List<int> selectedIconIndexs;
  final bool isOnlyOne;
  final String label;
  @override
  State<ExpansionIconCard> createState() => _ExpansionIconCardState();
}

class _ExpansionIconCardState extends State<ExpansionIconCard> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionCard(
      title: widget.label,
      child: Wrap(
        spacing: 15,
        children: List.generate(
          widget.icons.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                if (widget.isOnlyOne) {
                  selectedIndex = index;
                  widget.selectedIconIndexs.assignAll([index]);
                } else {
                  if (widget.selectedIconIndexs.contains(index)) {
                    widget.selectedIconIndexs.remove(index);
                  } else {
                    widget.selectedIconIndexs.add(index);
                  }
                }

                setState(() {});
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icons[index].iconData,
                    size: RS.w10 * 4,
                    color: widget.selectedIconIndexs.contains(index) ||
                            selectedIndex == index
                        ? Colors.pinkAccent
                        : null,
                  ),
                  SizedBox(height: RS.h10 / 2),
                  Text(
                    widget.icons[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.selectedIconIndexs.contains(index) ||
                                selectedIndex == index
                            ? Colors.pinkAccent
                            : null),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
