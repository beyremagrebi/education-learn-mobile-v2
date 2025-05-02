import 'package:flutter/material.dart';

import '../../../core/base/base_model.dart';
import '../../../core/base/base_view_model.dart';
import 'async_builder.dart';

class AsyncModelBuilder<Model extends BaseModel,
    ViewModel extends BaseViewModel> extends StatelessWidget {
  final ViewModel viewModel;
  final Model? model;
  final Widget? loadingWidget;
  final bool isEmpty;
  final Future Function()? refreshFunction;
  final Function(Model model) builder;

  const AsyncModelBuilder({
    super.key,
    required this.viewModel,
    required this.model,
    this.loadingWidget,
    required this.isEmpty,
    this.refreshFunction,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      apiStatus: viewModel.apiStatus(model, isEmpty: isEmpty),
      loadingWidget: loadingWidget,
      refreshFunction: refreshFunction,
      onSuccess: () => isEmpty
          ? const SizedBox.shrink()
          : refreshFunction != null
              ? RefreshIndicator(
                  onRefresh: () async => refreshFunction?.call(),
                  child: builder(model!),
                )
              : builder(model!),
    );
  }
}
