import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/drawer_item.dart';
import '../../../core/localization/flutter_localization.dart';
import '../../../core/base/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  MainViewModel(super.context) {
    scaffoldKey = GlobalKey<ScaffoldState>();

    tabController = TabController(
      length: bottomNavItemsLength,
      vsync: mainState,
    );
    tabController.addListener(() {
      onChangeTabIndexNavBar(tabController.index);
    });
  }

  // Const
  int get bottomNavItemsLength => 4;

  // UI
  late TabController tabController;
  late GlobalKey<ScaffoldState> scaffoldKey;
  DrawerItem selectedDrawerItem = DrawerItem.dashboard;

  bool get isDrawerOpen => scaffoldKey.currentState?.isDrawerOpen ?? false;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onChangeTabIndexNavBar(int index) {
    tabController.index = index;
    update();
  }

  void setTabController(TabController controller) {
    tabController = controller;
    if (kDebugMode) selectDrawerItem(DrawerItem.studyPlan);
  }

  void toggleDrawer() {
    if (isDrawerOpen) {
      scaffoldKey.currentState?.closeDrawer();
    } else {
      scaffoldKey.currentState?.openDrawer();
    }

    update();
  }

  void selectDrawerItem(DrawerItem item) {
    selectedDrawerItem = item;
    if (tabController.index != 0) {
      tabController.index = 0;
    }

    scaffoldKey.currentState?.closeDrawer();
  }
}
