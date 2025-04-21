import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../../../core/style/dimensions.dart';
import 'language_view_model.dart';
import 'widgets/language_item.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(title: Text(intl.languageTitle)),
        body: BackgroundImageSafeArea(
          svgAsset: Assets.bgMain,
          child: Padding(
            padding: Dimensions.paddingLarge,
            child: Column(
              children: [
                LanguageItem(
                  languageName: intl.englishLanguage,
                  countryName: intl.englishCountry,
                  countryCode: 'GB',
                  locale: Localization.localeEnglish,
                  viewModel: viewModel,
                ),
                Divider(
                    height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
                LanguageItem(
                  languageName: intl.frenchLanguage,
                  countryName: intl.frenchCountry,
                  countryCode: 'FR',
                  locale: Localization.localeFrench,
                  viewModel: viewModel,
                ),
                Divider(
                    height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
                LanguageItem(
                  languageName: intl.arabicLanguage,
                  countryName: intl.arabicCountry,
                  countryCode: 'TN',
                  locale: Localization.localeArabic,
                  viewModel: viewModel,
                ),
                Divider(
                    height: 1, color: Colors.grey.shade500.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
