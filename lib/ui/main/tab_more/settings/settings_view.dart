import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/ui/main/tab_more/settings/language/language_view.dart';
import 'package:studiffy/ui/main/tab_more/settings/theme/theme_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../../core/style/dimensions.dart';

import '../../../../utils/widgets/ui/setting_title_details.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(intl.settingsTitle),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: Container(
          margin: Dimensions.paddingExtraLargeHorizontal,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.m),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.surface.withOpacity(0.8),
                Theme.of(context).colorScheme.surface.withOpacity(0.6),
                Theme.of(context).colorScheme.surface.withOpacity(0.4),
              ])),
          padding: Dimensions.paddingLarge,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingTitleDetails(
                  title: intl.appThemeTitle,
                  description: intl.appThemeDescription,
                  icon: Icons.light_mode_outlined,
                  onTap: () {
                    navigateTo(context, const ThemeView());
                  },
                ),
                SettingTitleDetails(
                  title: intl.languageTitle,
                  description: intl.languageDescription,
                  icon: Icons.language_outlined,
                  onTap: () {
                    navigateTo(context, const LanguageView());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
