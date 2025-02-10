import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:ours_log/common/enums/icon_and_index.dart';
import 'package:ours_log/common/utilities/app_color.dart';
import 'package:ours_log/common/utilities/responsive.dart';
import 'package:ours_log/common/widgets/custom_expansion_card.dart';

class ExpansionIconCard extends StatefulWidget {
  const ExpansionIconCard(
      {super.key, required this.icons, required this.label});

  final List<IconAndIndex> icons;
  final String label;
  @override
  State<ExpansionIconCard> createState() => _ExpansionIconCardState();
}

class _ExpansionIconCardState extends State<ExpansionIconCard> {
  List<int> selectedIndexs = [];

  @override
  void initState() {
    super.initState();
  }

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
                setState(
                  () {
                    if (selectedIndexs.contains(index)) {
                      selectedIndexs.remove(index);
                    } else {
                      selectedIndexs.add(index);
                    }
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icons[index].iconData,
                    size: RS.width10 * 4,
                    color: selectedIndexs.contains(index)
                        ? Colors.pinkAccent
                        : null,
                  ),
                  SizedBox(height: RS.height10 / 2),
                  Text(
                    widget.icons[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedIndexs.contains(index)
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
