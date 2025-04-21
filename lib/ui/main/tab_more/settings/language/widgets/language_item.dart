import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';

import '../../../../../../core/style/dimensions.dart';
import '../language_view_model.dart';

class LanguageItem extends StatelessWidget {
  final String languageName;
  final String countryName;
  final String countryCode;
  final LanguageViewModel viewModel;
  final Locale locale;
  const LanguageItem(
      {super.key,
      required this.languageName,
      required this.countryName,
      required this.countryCode,
      required this.viewModel,
      required this.locale});

  @override
  Widget build(BuildContext context) {
    return buildLanguageItem(
        context: context,
        languageName: languageName,
        countryName: countryName,
        countryCode: countryCode,
        locale: locale,
        viewModel: viewModel);
  }

  Widget buildLanguageItem({
    required BuildContext context,
    required String languageName,
    required String countryName,
    required String countryCode,
    required Locale locale,
    required LanguageViewModel viewModel,
  }) {
    String? flagAsset;

    switch (countryCode) {
      case 'TN':
        flagAsset = Assets.tunisiaFlag;
        break;
      case 'FR':
        flagAsset = Assets.franceFlag;
        break;
      case 'GB':
        flagAsset = Assets.ukFlag;
        break;
    }

    return InkWell(
      onTap: () => viewModel.setLocale(locale),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            if (flagAsset != null)
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: Dimensions.mediumBorderRadius,
                ),
                child: Image.asset(
                  flagAsset,
                  height: 60,
                  width: 60 * 4 / 3,
                  fit: BoxFit.fill,
                ),
              ),
            const SizedBox(width: 30),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Text(languageName)),
                  const SizedBox(width: 8),
                  Expanded(child: Text('($countryName)')),
                ],
              ),
            ),
            viewModel.locale == locale
                ? const Icon(Icons.check)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
