import 'package:flutter/material.dart';

import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';

class SubjectHeader extends StatelessWidget {
  final String name;
  final Color iconColor;
  const SubjectHeader({
    super.key,
    required this.name,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.book,
            color: Colors.white,
            size: 32,
          ),
        ),
        Dimensions.widthMedium,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Dimensions.heightSmall,
              Text(
                'Programme: $name',
                style: TextStyle(
                  color: AppTheme.disabledColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
