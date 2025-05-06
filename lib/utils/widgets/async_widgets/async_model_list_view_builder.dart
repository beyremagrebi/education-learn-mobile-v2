import 'package:flutter/material.dart';

import '../../../core/base/base_model.dart';
import '../../../core/base/base_view_model.dart';
import '../loading/no_data_refresh_indicatior.dart';
import 'async_model_list_builder.dart';

class AsyncModelListViewBuilder<Model extends BaseModel,
    ViewModel extends BaseViewModel> extends StatelessWidget {
  final ViewModel viewModel;
  final List<Model>? modelList;
  final Widget? loadingShimmer;
  final RefreshCallback? refreshFunction;
  final EdgeInsets? padding;
  final Widget Function(Model model, int index) builder;
  final ScrollController? scrollController;
  final bool hideIfEmpy;
  final Axis scrollDirection;
  final bool reverse;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final int? maxItem;

  const AsyncModelListViewBuilder({
    super.key,
    required this.viewModel,
    required this.modelList,
    this.loadingShimmer,
    this.refreshFunction,
    this.padding,
    required this.builder,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.hideIfEmpy = false,
    this.crossAxisCount,
    this.childAspectRatio,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.maxItem,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncModelListBuilder(
      viewModel: viewModel,
      modelList: modelList,
      hideIfEmpty: hideIfEmpy,
      loadingWidget: loadingShimmer,
      builder: (modelList) => modelList.isEmpty
          ? NoDataRefreshIndicator(
              onRefresh: () async => refreshFunction?.call(),
            )
          : ListView.builder(
              scrollDirection: scrollDirection,
              controller: scrollController,
              padding: padding,
              reverse: reverse,
              itemCount: maxItem ?? modelList.length,
              itemBuilder: (context, index) => builder(modelList[index], index),
            ),
      refreshFunction: refreshFunction,
    );
  }
}
