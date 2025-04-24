import 'package:flutter/material.dart';

import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

import 'package:studiffy/utils/view_models/main/main_drawer_view_mdoel.dart';

import '../../../core/style/dimensions.dart';
import '../../view_models/main/global_user_consumer.dart';
import '../media/api_image_widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainDrawerViewModel(context),
      child: Consumer<MainDrawerViewModel>(
        builder: (context, viewModel, child) => Column(
          children: [
            _buildLogo(context),
            _buildHeader(context),
            Dimensions.heightHuge,
            Expanded(child: Container()),
            Dimensions.heightHuge,
            _buildFooterDrawer(),
            Dimensions.heightMedium,
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Image.asset(
        Assets.logoPstc(context),
        fit: BoxFit.contain,
        alignment: Alignment.center,
        width: 100,
        height: 30,
        cacheWidth: 210,
        cacheHeight: 50,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    const hasResponsableFor = true;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.m),
      padding: Dimensions.paddingSmall,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(90, 0, 100, 0.7),
        borderRadius: BorderRadius.all(Dimensions.mediumRadius),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar(context),
              Expanded(child: _buildUserDetails(context)),
              if (hasResponsableFor)
                IconButton(
                  onPressed: () {}, // Replace if needed
                  icon: const Icon(Symbols.unfold_more),
                  color: Colors.white,
                ),
            ],
          ),
          if (hasResponsableFor) Container(),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.m),
      child: ApiImageWidget(
        imageFilename: SessionManager.user.imageFilename,
        isMen: SessionManager.user.isMen,
        hasImageViewer: true,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    return GlobalUserConsumer(
      builder: (context, user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.firstName} ${user.lastName}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
          Text(
            SessionManager.user.email ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterDrawer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.m),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text(
              intl.settingsMenu,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.support_outlined),
            title: Text(intl.support),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
