import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studiffy/core/localization/flutter_localization.dart';
import 'package:studiffy/ui/main/tab_more/settings/language/language_view_model.dart';
import 'package:studiffy/ui/main/tab_more/settings/theme/theme_view_mdoel.dart';

import 'package:studiffy/utils/app/app_utils.dart';

import 'utils/app/preferences/theme_preferences.dart';

void main() async {
  await AppUtils.executePreLaunch();
  final savedTheme = await ThemePreference.shared.load() ?? ThemeMode.system;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeViewModel(context, savedTheme),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageViewModel(context),
        ),
      ],
      child: const FlutterLocalization(),
    ),
  );
}
