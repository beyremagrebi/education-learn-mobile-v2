import 'package:flutter/material.dart';

import '../../base/base_input_widget.dart';

class InputText extends StatelessWidget {
  final String? label;
  final String? hint;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool isRequired;
  final IconData? suffixIcon;
  final EdgeInsets? padding;
  final bool? enabled;
  final bool obscureText;

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String? text)? validator;
  final void Function(String)? onChanged;

  final Color? borderColor;
  final Color? shadowColor;
  final VoidCallback? onSuffixIconTap;

  const InputText(
      {super.key,
      required this.controller,
      this.label,
      this.hint,
      this.maxLength,
      this.minLines,
      this.maxLines = 1,
      this.isRequired = false,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.onChanged,
      this.suffixIcon,
      this.padding,
      this.enabled,
      this.shadowColor,
      this.obscureText = false,
      this.borderColor,
      this.onSuffixIconTap});

  @override
  Widget build(BuildContext context) {
    final valueNotifier = ValueNotifier(controller?.text);

    return BaseInputWidget(
      shadowColor: shadowColor,
      borderColor: borderColor,
      isCircular: false,
      valueNotifier: valueNotifier,
      label: label,
      padding: padding,
      isRequired: isRequired,
      additionalValidator: validator,
      widgetBuilder: (formState) => TextField(
        controller: controller,
        onTapOutside: (value) => FocusScope.of(context).unfocus(),
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: () => onSuffixIconTap?.call(),
                  child: Icon(suffixIcon),
                )
              : null,
          border: InputBorder.none,
          hintText: hint,
        ),
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        onChanged: (value) {
          valueNotifier.value = value;
          onChanged?.call(value);
        },
        enabled: enabled,
      ),
    );
  }
}
