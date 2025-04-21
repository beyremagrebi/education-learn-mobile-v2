import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
      ),
    );
  }
}
