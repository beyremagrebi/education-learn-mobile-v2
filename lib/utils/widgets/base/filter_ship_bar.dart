import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studiffy/core/style/dimensions.dart';

import '../../view_models/filter_view_model.dart';

class FilterChipBar<T> extends StatelessWidget {
  final List<T> filters;
  final FilterViewModel<T> viewModel;
  final String Function(T) getLabel;

  const FilterChipBar({
    super.key,
    required this.filters,
    required this.viewModel,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters
            .map((filter) => _buildFilterChip(filter, viewModel, context))
            .toList(),
      ),
    );
  }

  Widget _buildFilterChip(
      T filter, FilterViewModel<T> viewModel, BuildContext context) {
    final bool isSelected = viewModel.isFilterSelected(filter);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: FilterChip(
          label: Text(
            getLabel(filter),
            style: TextStyle(
              color:
                  isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          avatar: isSelected
              ? const Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Colors.white,
                )
              : null,
          selected: isSelected,
          showCheckmark: false,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.mediumBorderRadius,
            side: BorderSide(
              color: isSelected ? Colors.transparent : theme.dividerColor,
              width: 1,
            ),
          ),
          selectedColor: theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: isSelected ? 2 : 0,
          pressElevation: 4,
          onSelected: (_) {
            // Add haptic feedback for better interaction
            HapticFeedback.lightImpact();
            viewModel.toggleFilter(filter);
          },
        ),
      ),
    );
  }
}
