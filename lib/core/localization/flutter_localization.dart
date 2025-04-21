import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/ui/main/tab_more/settings/language/language_view_model.dart';
import 'package:studiffy/ui/main/tab_more/settings/theme/theme_view_mdoel.dart';
import 'package:studiffy/ui/splash_screen_view.dart';

import '../../global_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
BuildContext get mainContext => _navigatorKey.currentContext!;

NavigatorState get mainState => _navigatorKey.currentState!;

GlobalKey<GlobalProvidersState> _globalProvidersKey = GlobalKey();

GlobalProvidersState get globalProvidersState =>
    _globalProvidersKey.currentState!;

OverlayState? mainOverlayState;

class FlutterLocalization extends StatelessWidget {
  const FlutterLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeViewModel, LanguageViewModel>(
      builder: (context, themeNotifier, languageViewModel, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          locale: languageViewModel.locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.themeMode,
          title: 'studiffy',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (context) {
            intl = AppLocalizations.of(context);
            return intl.appName;
          },
          home: const SplashScreenView(),
        );
      },
    );
  }
}
