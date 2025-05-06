import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/ui/main/tab_course/course_view.dart';
import 'package:studiffy/ui/main/tab_more/more_tab_view.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/main/main_app_bar.dart';

import '../../utils/view_models/main/main_view_model.dart';
import '../../utils/widgets/main/main_drawer.dart';
import '../../utils/widgets/transparent_shadow_decoration.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewModel(context),
      builder: (context, child) {
        final viewModel = context.read<MainViewModel>();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(flexibleSpace: const MainAppBar()),
          body: Scaffold(
            extendBodyBehindAppBar: true,
            drawerScrimColor: Colors.transparent.withOpacity(0.5),
            key: viewModel.scaffoldKey,
            onDrawerChanged: (isOpened) => viewModel.update(),
            drawer: SafeArea(child: _buildMainDrawer()),
            body: _buildMainBody(context),
            bottomNavigationBar: _buildBottomNavigationBar(context),
          ),
        );
      },
    );
  }

  Widget _buildMainBody(BuildContext context) {
    final viewModel = context.read<MainViewModel>();
    final List<Widget> tabs = [
      BackgroundImageSafeArea(svgAsset: Assets.bgMain, child: Container()),
      BackgroundImageSafeArea(svgAsset: Assets.bgMain, child: Container()),
      const CourseView(),
      const MoreTabView(),
    ];

    return TabBarView(
      controller: viewModel.tabController,
      children: tabs,
    );
  }

  Widget _buildMainDrawer() {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: const SizedBox(),
        ),
        const Drawer(
          width: 280,
          clipBehavior: Clip.antiAlias,
          child: BackgroundImageSafeArea(
              svgAsset: Assets.bgMain, child: MainDrawer()),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    const tabCount = 4;

    return Container(
      decoration: const TransparentShadowDecoration(blurRadius: 5),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Consumer<MainViewModel>(
            builder: (context, viewModel, child) => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              iconSize: 25,
              elevation: 0,
              selectedItemColor: Theme.of(context).colorScheme.onSurface,
              unselectedItemColor: Colors.grey,
              currentIndex: viewModel.tabController.index,
              items: _buildBottomNavigationItems(tabCount, viewModel, context),
              onTap: viewModel.onChangeTabIndexNavBar,
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationItems(
      int tabCount, MainViewModel viewModel, BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(viewModel.tabController.index == 0
            ? Icons.home
            : Icons.home_outlined),
        label: intl.homeTab,
      ),
      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(viewModel.tabController.index == 1
                ? Icons.chat
                : Icons.chat_outlined),
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text('4',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        )),
              ),
            ),
          ],
        ),
        label: intl.chatTab,
      ),
    ];
    if (tabCount > 3) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(viewModel.tabController.index == 2
              ? Icons.assignment
              : Icons.assignment_outlined),
          label: intl.courseTab,
        ),
      );
    }
    items.add(
      BottomNavigationBarItem(
        icon: Icon(viewModel.tabController.index == (tabCount - 1)
            ? Icons.widgets
            : Icons.widgets_outlined),
        label: intl.menuTab,
      ),
    );

    return items;
  }
}
