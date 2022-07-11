import 'package:flutter/material.dart';

import '../../setting/color/app_color.dart';

class CustomButton extends StatelessWidget {
  final BorderRadius? borderRadius;
  final String? text;
  final Widget? child;
  final bool isfill;
  final bool isEnable;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;
  const CustomButton({
    Key? key,
    this.onTap,
    this.borderRadius,
    this.text,
    this.child,
    this.isfill = true,
    this.textStyle,
    this.fillColor,
    this.borderColor,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: Material(
        child: InkWell(
          onTap: isEnable ? onTap ?? () {} : null,
          highlightColor: isfill
              ? Colors.white.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          splashColor: isfill
              ? Colors.white.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          child: Ink(
            height: 50,
            decoration: BoxDecoration(
              color: isEnable
                  ? (isfill
                      ? fillColor ?? AppColor.primarySwatch
                      : Colors.transparent)
                  : Colors.black12,
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              border: isfill
                  ? const Border.symmetric()
                  : Border.all(color: borderColor ?? AppColor.primarySwatch),
            ),
            child: Container(
              alignment: Alignment.center,
              child: child ??
                  Text(
                    text ?? 'Text',
                    style: textStyle ??
                        TextStyle(color: isfill ? Colors.white : Colors.black),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
