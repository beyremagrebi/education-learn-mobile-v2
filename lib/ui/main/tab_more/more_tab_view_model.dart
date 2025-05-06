import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/ui/main/tab_more/settings/settings_view.dart';
import 'package:studiffy/ui/main/tab_more/timetable/time_table_view.dart';
import 'package:studiffy/utils/widgets/main/menu.dart';

import '../../../utils/view_models/tab_view_model.dart';
import 'class/class_list_view.dart';

class MoreTabViewModel extends TabViewModel {
  MoreTabViewModel(super.context);

  List<Menu> get leftColumnMenus {
    return [
      Menu(
        title: intl.classMenu,
        backgroundAsset: Assets.menuBgRose,
        icon: Icons.class_outlined,
        materialPage: const ClassListView(),
      ),
    ];
  }

  List<Menu> get rightColumnMenus {
    return [
      Menu(
        title: intl.scheduleMenu,
        backgroundAsset: Assets.menuBgTurquoise,
        icon: Icons.class_outlined,
        materialPage: const TimeTableView(),
      ),
      Menu(
        title: intl.settingsMenu,
        backgroundAsset: Assets.menuBgBlueAlt,
        icon: Icons.settings_outlined,
        materialPage: const SettingsView(),
      ),
    ];
  }

  void onLanguageChanged() {
    update();
  }
}
