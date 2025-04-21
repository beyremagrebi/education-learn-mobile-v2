import 'package:flutter/material.dart';

import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import 'package:studiffy/utils/view_models/main/main_drawer_view_mdoel.dart';

import '../../../core/style/dimensions.dart';
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
      child: ApiImageWidget(
        imageFilename: Assets.logoPstc(context),
        isAsset: true,
        fit: BoxFit.contain,
        backgroundColor: Colors.transparent,
        height: 30,
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
        imageFilename: Assets.logoStuddify(context),
        isAsset: true,
        backgroundColor: Colors.white,
        placeholderPadding: Dimensions.paddingSmall,
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'beyrem agrebi',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ),
        Text(
          'beyrem.agrebi@gmail.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ],
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
