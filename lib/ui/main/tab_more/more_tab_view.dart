import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/ui/main/tab_more/settings/language/language_view_model.dart';

import '../../../core/constant/assets.dart';
import '../../../core/style/dimensions.dart';
import '../../../utils/widgets/background_image_safe_area.dart';
import '../../../utils/widgets/ui/menu_widgets.dart';
import 'more_tab_view_model.dart';

class MoreTabView extends StatelessWidget {
  const MoreTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreTabViewModel(context),
      child: Consumer2<MoreTabViewModel, LanguageViewModel>(
        builder: (context, viewModel, languageViewModel, child) {
          return BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            safeArea: false,
            blurTopBarViewModel: viewModel,
            child: SingleChildScrollView(
              controller: viewModel.scrollController,
              padding: Dimensions.paddingExtraLargeHorizontal,
              child: Column(
                children: [
                  Dimensions.topBarHeight(context),
                  _buildMenuGrid(viewModel),
                  Dimensions.bottomBarHeight(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuGrid(MoreTabViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: List.generate(
              viewModel.leftColumnMenus.length,
              (index) => MenuWidget(
                height: index % 2 == 0 ? 260.0 : 210.0,
                menu: viewModel.leftColumnMenus[index],
              ),
            ),
          ),
        ),
        Dimensions.widthLarge,
        Expanded(
          child: Column(
            children: List.generate(
              viewModel.rightColumnMenus.length,
              (index) => MenuWidget(
                height: index % 2 == 0 ? 210.0 : 260.0,
                menu: viewModel.rightColumnMenus[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
