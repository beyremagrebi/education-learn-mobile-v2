import 'package:flutter/material.dart';

import '../../../core/base/base_model.dart';
import '../../../core/base/base_view_model.dart';
import 'async_builder.dart';

class AsyncNullableModelBuilder<Model extends BaseModel,
    ViewModel extends BaseViewModel> extends StatelessWidget {
  final ViewModel viewModel;
  final Model? model;
  final bool displayIfNull;
  final Widget? loadingWidget;
  final Future Function()? refreshFunction;
  final Function(Model? model) builder;

  const AsyncNullableModelBuilder({
    super.key,
    required this.viewModel,
    required this.model,
    required this.displayIfNull,
    this.loadingWidget,
    this.refreshFunction,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      apiStatus: viewModel.apiStatus(model),
      loadingWidget: loadingWidget,
      refreshFunction: refreshFunction,
      displayIfNull: displayIfNull,
      onSuccess: () => refreshFunction != null
          ? RefreshIndicator(
              onRefresh: () async => refreshFunction?.call(),
              child: builder(model),
            )
          : builder(model),
    );
  }
}
