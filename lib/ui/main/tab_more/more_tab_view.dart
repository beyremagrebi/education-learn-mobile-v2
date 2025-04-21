import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studiffy/core/extensions/localisation_string.dart';

import '../../../core/constant/assets.dart';
import '../../../core/localization/loalisation.dart';
import '../../../core/style/dimensions.dart';
import '../../../utils/widgets/background_image_safe_area.dart';
import '../../../utils/widgets/main/menu.dart';
import '../../../utils/widgets/ui/menu_widgets.dart';
import 'more_tab_view_model.dart';

class MoreTabView extends StatelessWidget {
  const MoreTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreTabViewModel(context),
      child: Builder(
        builder: (context) {
          final viewModel = context.watch<MoreTabViewModel>();

          final menuMetaList = viewModel.getSortedMenuMeta();

          final menuList = menuMetaList.map((meta) {
            return Menu(
              title: intl.get(meta['titleKey']),
              backgroundAsset: meta['backgroundAsset'],
              icon: meta['icon'],
              materialPage: meta['pageBuilder'](context),
            );
          }).toList();

          final leftColumnMenus = <Menu>[];
          final rightColumnMenus = <Menu>[];

          for (int i = 0; i < menuList.length; i++) {
            if (i % 2 == 0) {
              leftColumnMenus.add(menuList[i]);
            } else {
              rightColumnMenus.add(menuList[i]);
            }
          }

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: List.generate(
                            leftColumnMenus.length,
                            (index) => MenuWidget(
                              height: index % 2 == 0 ? 260.0 : 210.0,
                              menu: leftColumnMenus[index],
                            ),
                          ),
                        ),
                      ),
                      Dimensions.widthLarge,
                      Expanded(
                        child: Column(
                          children: List.generate(
                            rightColumnMenus.length,
                            (index) => MenuWidget(
                              height: index % 2 == 0 ? 210.0 : 260.0,
                              menu: rightColumnMenus[index],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Dimensions.bottomBarHeight(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
