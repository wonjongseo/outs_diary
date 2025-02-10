import 'package:flutter/material.dart';

class CDropdownButton extends StatelessWidget {
  const CDropdownButton(
      {super.key, required this.items, required this.onChanged});
  final List items;
  final Function(dynamic) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: const SizedBox(),
      iconSize: 32,
      items: List.generate(items.length, (index) {
        return DropdownMenuItem(
          value: items[index],
          child: Text(items[index]),
        );
      }),
      onChanged: onChanged,
    );
  }
}
