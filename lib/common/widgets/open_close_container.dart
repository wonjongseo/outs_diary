import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:ours_log/common/enums/icon_and_index.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';

class ExpansionIconCard extends StatefulWidget {
  const ExpansionIconCard({
    Key? key,
    required this.icons,
    required this.selectedIconIndexs,
    this.isOnlyOne = false,
    required this.label,
    this.width,
  }) : super(key: key);

  final List<IconAndIndex> icons;
  final List<int> selectedIconIndexs;
  final bool isOnlyOne;
  final String label;
  final double? width;

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
        children: List.generate(
          widget.icons.length,
          (index) => Padding(
            padding: const EdgeInsets.all(4.0),
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
              child: SizedBox(
                width: widget.width ?? RS.w10 * 6.5,
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
                    AutoSizeText(
                      widget.icons[index].title,
                      textAlign: TextAlign.center,
                      maxFontSize: 13,
                      maxLines: 1,
                      style: TextStyle(
                        color: widget.selectedIconIndexs.contains(index) ||
                                selectedIndex == index
                            ? Colors.pinkAccent
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
