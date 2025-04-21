import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../../../core/style/dimensions.dart';
import 'theme_view_mdoel.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(title: Text(intl.themeTitle)),
        body: BackgroundImageSafeArea(
          svgAsset: Assets.bgMain,
          child: Padding(
            padding: Dimensions.paddingMedium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Dimensions.heightLarge,
                RadioListTile<ThemeMode>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      const Icon(Icons.light_mode),
                      Dimensions.widthSmall,
                      Text(intl.lightTheme),
                    ],
                  ),
                  value: ThemeMode.light,
                  groupValue: viewModel.themeMode,
                  onChanged: viewModel.setTheme,
                ),
                RadioListTile<ThemeMode>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      const Icon(Icons.dark_mode),
                      Dimensions.widthSmall,
                      Text(intl.darkTheme),
                    ],
                  ),
                  value: ThemeMode.dark,
                  groupValue: viewModel.themeMode,
                  onChanged: viewModel.setTheme,
                ),
                RadioListTile<ThemeMode>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      const Icon(Icons.phone_android),
                      Dimensions.widthSmall,
                      Text(intl.systemTheme),
                    ],
                  ),
                  value: ThemeMode.system,
                  groupValue: viewModel.themeMode,
                  onChanged: viewModel.setTheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
