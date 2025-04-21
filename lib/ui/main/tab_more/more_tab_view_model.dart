import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/ui/main/tab_more/settings/settings_view.dart';
import '../../../utils/view_models/tab_view_model.dart';

class MoreTabViewModel extends TabViewModel {
  MoreTabViewModel(super.context);

  List<Map<String, dynamic>> getSortedMenuMeta() {
    List<Map<String, dynamic>> rightMenuMeta = [
      {
        'titleKey': 'scheduleMenu',
        'backgroundAsset': Assets.menuBgTurquoise,
        'icon': Icons.class_outlined,
        'pageBuilder': (BuildContext context) => Scaffold(
              appBar: AppBar(title: const Text('')),
            ),
      },
      {
        'titleKey': 'settingsMenu',
        'backgroundAsset': Assets.menuBgBlueAlt,
        'icon': Icons.settings_outlined,
        'pageBuilder': (BuildContext context) => const SettingsView(),
      },
    ];

    List<Map<String, dynamic>> leftMenuMeta = [
      {
        'titleKey': 'classMenu',
        'backgroundAsset': Assets.menuBgRose,
        'icon': Icons.class_outlined,
        'pageBuilder': (BuildContext context) => Scaffold(
              appBar: AppBar(title: const Text('')),
            ),
      },
    ];

    List<Map<String, dynamic>> sorted = [];
    int i = 0;
    while (i < leftMenuMeta.length || i < rightMenuMeta.length) {
      if (i < leftMenuMeta.length) sorted.add(leftMenuMeta[i]);
      if (i < rightMenuMeta.length) sorted.add(rightMenuMeta[i]);
      i++;
    }
    return sorted;
  }
}
