import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:ours_log/common/enums/icon_and_index.dart';
import 'package:ours_log/common/utilities/app_color.dart';

import 'package:ours_log/common/widgets/custom_expansion_card.dart';

class ExpansionIconCard extends StatefulWidget {
  const ExpansionIconCard({
    Key? key,
    required this.icons,
    required this.selectedIconIndexs,
    this.isOnlyOne = false,
    this.initiallyExpanded = true,
    required this.label,
    this.onExpansionChanged,
    this.width,
  }) : super(key: key);

  final List<IconAndIndex> icons;
  final List<int> selectedIconIndexs;
  final bool isOnlyOne;
  final String label;
  final bool initiallyExpanded;
  final double? width;
  final Function(bool)? onExpansionChanged;
  @override
  State<ExpansionIconCard> createState() => _ExpansionIconCardState();
}

class _ExpansionIconCardState extends State<ExpansionIconCard> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionCard(
        onExpansionChanged: widget.onExpansionChanged,
        initiallyExpanded: widget.initiallyExpanded,
        title: widget.label,
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: widget.icons.length,
            itemBuilder: (context, index) {
              return Padding(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icons[index].iconData,
                        size: 10 * 4,
                        color: widget.selectedIconIndexs.contains(index) ||
                                selectedIndex == index
                            ? AppColors.primaryColor
                            : null,
                      ),
                      Text(
                        widget.icons[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                          color: widget.selectedIconIndexs.contains(index) ||
                                  selectedIndex == index
                              ? AppColors.primaryColor
                              : null,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
