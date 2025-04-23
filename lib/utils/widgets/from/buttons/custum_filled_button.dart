import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback? onPressed;
  final Size? maximumSize;

  const CustomFilledButton(
      {super.key,
      required this.widget,
      required this.onPressed,
      this.maximumSize});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            maximumSize: maximumSize ?? const Size.fromWidth(double.maxFinite)),
        onPressed: onPressed,
        child: widget);
  }
}
