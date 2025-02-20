import 'package:flutter/material.dart';

import 'package:ours_log/common/utilities/responsive.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.widget,
    this.maxLines,
    this.readOnly,
    this.controller,
    this.sufficIcon,
    this.keyboardType,
    this.onTap,
    this.onFieldSubmitted,
    this.maxLength,
  }) : super(key: key);

  final String? hintText;
  final Widget? widget;
  final int? maxLines;
  final bool? readOnly;
  final TextEditingController? controller;
  final Widget? sufficIcon;
  final Function()? onTap;
  final Function(String?)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final int? maxLength;
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
              maxLength: maxLength,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              onTap: onTap,
              readOnly: readOnly ?? false,
              style: TextStyle(fontSize: RS.width12),
              maxLines: maxLines ?? 1,
              controller: controller,
              decoration: InputDecoration(
                counterText: "",
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                suffixIcon: sufficIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: RS.w10),
                        child: sufficIcon,
                      )
                    : null,
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
