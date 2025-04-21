import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';

import '../../../core/style/dimensions.dart';

import '../../view_models/main/main_view_model.dart';
import '../media/api_image_widget.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: Dimensions.paddingSmallHorizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildMenuButton(),
                _buildLogo(context),
              ],
            ),
            _buildAppBarIcons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) => IconButton(
        icon: Icon(
          viewModel.isDrawerOpen ? Icons.menu_open : Icons.menu,
          size: Dimensions.iconSizeMedium,
        ),
        onPressed: viewModel.toggleDrawer,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 110,
        child: ApiImageWidget(
          backgroundColor: Colors.transparent,
          isAsset: true,
          imageFilename: Assets.logoPstc(context),
          fit: BoxFit.contain,
        ));
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Widget? additionalWidget,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: Dimensions.paddingSmall,
        child: additionalWidget ??
            Icon(
              icon,
            ),
      ),
    );
  }

  Widget _buildAppBarIcons(BuildContext context) {
    return Container(
      margin: Dimensions.paddingMedium,
      child: Row(
        children: [
          _buildActionButton(
            icon: Icons.account_circle,
            onPressed: () {
              // Navigate to profile
            },
          ),

          _buildActionButton(
            icon: Icons.notifications_outlined,
            onPressed: () {
              // Navigate to notifications
            },
            additionalWidget: const Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications,
                ),
                // No unread count for now
              ],
            ),
          ),

          // Static facility action button
          _buildActionButton(
            icon: Icons.account_balance,
            onPressed: () {
              // Show facility details
            },
          ),

          // Static user list action button
          _buildActionButton(
            icon: Icons.people_alt_outlined,
            onPressed: () {
              // Show children list
            },
          ),
        ],
      ),
    );
  }
}
