import 'package:flutter/material.dart';

import '../../../core/style/dimensions.dart';

class SettingTitleDetails extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? customIcon;

  const SettingTitleDetails({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customIcon ??
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 28,
                ),
            Dimensions.widthLarge,
            Expanded(
              child: Container(
                padding: Dimensions.paddingSmallVertical,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade400,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
