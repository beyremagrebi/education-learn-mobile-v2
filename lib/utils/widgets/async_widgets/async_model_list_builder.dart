import 'package:flutter/material.dart';

import '../../../core/base/base_model.dart';
import '../../../core/base/base_view_model.dart';
import 'async_builder.dart';
import 'empty_data_widget.dart';

class AsyncModelListBuilder<Model extends BaseModel,
    ViewModel extends BaseViewModel> extends StatelessWidget {
  final ViewModel viewModel;
  final List<Model>? modelList;
  final Widget? loadingWidget;
  final RefreshCallback? refreshFunction;
  final Function(List<Model> modelList) builder;
  final Color? textColor;
  final bool hideIfEmpty;
  final String? emptyMessage;
  final String? emptyTitle;
  final IconData? emptyIcon;

  const AsyncModelListBuilder({
    super.key,
    required this.viewModel,
    required this.modelList,
    this.loadingWidget,
    this.refreshFunction,
    required this.builder,
    this.hideIfEmpty = false,
    this.textColor,
    this.emptyMessage,
    this.emptyTitle,
    this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      apiStatus: viewModel.apiStatus(modelList),
      loadingWidget: loadingWidget,
      refreshFunction: refreshFunction,
      onSuccess: () => refreshFunction != null
          ? Center(
              child: RefreshIndicator(
                onRefresh: refreshFunction!,
                child: modelList!.isEmpty
                    ? _buildDataIsEmptyWidget()
                    : builder(modelList!),
              ),
            )
          : modelList!.isEmpty
              ? _buildDataIsEmptyWidget()
              : builder(modelList!),
    );
  }

  Widget _buildDataIsEmptyWidget() {
    return Visibility(
      visible: !hideIfEmpty,
      child: EmptyDataWidget(
        message: emptyMessage ?? 'Aucune donnée disponible',
        buttonText: 'Actualiser',
        onRefresh: refreshFunction,
        textColor: textColor,
        icon: emptyIcon,
        title: emptyTitle,
      ),
    );
  }
}
