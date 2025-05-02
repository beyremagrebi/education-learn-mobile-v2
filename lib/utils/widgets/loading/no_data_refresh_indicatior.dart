import 'package:flutter/material.dart';

class NoDataRefreshIndicator extends StatelessWidget {
  final String? text;
  final Function? onRefresh;

  const NoDataRefreshIndicator({
    super.key,
    this.text,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
              child: Center(child: Text(text ?? 'intl.noData'))),
        ],
      ),
    );
  }
}
