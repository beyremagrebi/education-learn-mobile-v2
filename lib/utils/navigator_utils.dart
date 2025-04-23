import 'package:flutter/material.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/ui/main/main_view.dart';

import '../core/localization/flutter_localization.dart';

Future navigateTo(BuildContext? context, Widget view) {
  return Navigator.of(context ?? mainContext).push(
    MaterialPageRoute(builder: (context) => view),
  );
}

Future navigateToDeleteTree(BuildContext? context, Widget view) {
  return Navigator.of(context ?? mainContext).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => PopScope(canPop: false, child: view),
    ),
    (route) => false,
  );
}

Future<void> navigateToMainScreen(BuildContext context, User user) async {
  globalProvidersState.initialize(user.id!);
  navigateToDeleteTree(context, const MainView());
}
