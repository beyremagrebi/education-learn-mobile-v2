import 'package:flutter/material.dart';
import 'package:studiffy/core/style/dimensions.dart';

import '../../core/style/themes/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const CustomInputField({
    super.key,
    this.hintText = '',
    this.prefixIcon,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLight = AppTheme.islight;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
        borderRadius: Dimensions.mediumBorderRadius,
        border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isLight ? Colors.grey.shade800 : Colors.white,
            ),
      ),
    );
  }
}
