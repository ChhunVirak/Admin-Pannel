import 'package:flutter/material.dart';

import '../../setting/color/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? label;
  final Color? borderColor;
  final TextStyle? labelstyle;
  final TextStyle? style;
  final bool? obscureText;
  final TextEditingController? controller;
  final EdgeInsetsGeometry padding;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  const CustomTextFormField(
      {Key? key,
      this.onSaved,
      this.onChanged,
      this.hintText,
      this.labelText,
      this.label,
      this.labelstyle,
      this.padding = const EdgeInsets.only(bottom: 20),
      this.controller,
      this.borderColor,
      this.obscureText,
      this.validator,
      this.style,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(label ?? '', style: labelstyle),
                )
              : const SizedBox(),
          TextFormField(
            style: style ??
                Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            obscureText: obscureText ?? false,
            controller: controller,
            onSaved: onSaved,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: hintText,
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: borderColor ?? AppColor.primarySwatch, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: borderColor ?? AppColor.primarySwatch, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
