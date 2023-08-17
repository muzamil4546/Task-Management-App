import 'package:flutter/material.dart';
import 'package:task_management_app/utils/colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final InputDecoration? inputDecoration;
  final String? hintText;
  final Widget? label;
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final Color? color;
  const CustomFormField({
    super.key,
    this.textEditingController,
    this.textInputAction,
    this.inputDecoration,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputType,
    this.validator,
    this.title,
    this.label,
    this.obscureText,
    this.focusedBorder,
    this.enabledBorder,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ColorUtils colorUtils = ColorUtils();
    return TextFormField(
        controller: textEditingController,
        textInputAction: textInputAction,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            label: label,
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconColor: colorUtils.lightBlueColor,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder),
        validator: validator,
        keyboardType: textInputType);
  }
}
