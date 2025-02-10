import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ours_log/common/utilities/responsive.dart';

import '../utilities/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.widget,
    this.maxLines,
  }) : super(key: key);

  final String? hintText;
  final Widget? widget;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: RS.width12),
              maxLines: maxLines ?? 1,
              decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                // suffixIcon: Text('c'),
                contentPadding: maxLines != null
                    ? EdgeInsets.all(RS.width15)
                    : EdgeInsets.symmetric(horizontal: RS.width15),
                hintText: hintText,
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          if (widget != null) widget!
        ],
      ),
    );
  }
}
