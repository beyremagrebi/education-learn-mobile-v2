import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(getLabel(filter)),
        selected: viewModel.isFilterSelected(filter),
        onSelected: (_) {
          viewModel.toggleFilter(filter);
        },
      ),
    );
  }
}
