import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/ui/main/profile/edit_profile_view.dart';
import 'package:studiffy/ui/main/tab_more/settings/language/language_view.dart';
import 'package:studiffy/ui/main/tab_more/settings/theme/theme_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/view_models/main/global_user_consumer.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/from/buttons/custum_filled_button.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';
import 'package:studiffy/utils/widgets/transparent_shadow_decoration.dart';

import '../../../../core/style/dimensions.dart';

import '../../../../utils/app/session/session_manager.dart';
import '../../../../utils/widgets/ui/setting_title_details.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(intl.settingsTitle),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: Padding(
          padding: Dimensions.paddingExtraLarge,
          child: Column(
            children: [
              _buildProfileUser(context),
              Dimensions.heightHuge,
              _buildSettingsItem(context),
              Dimensions.heightHuge,
              _buildLogoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: TransparentShadowDecoration(
            color: Theme.of(context).colorScheme.onSurface),
        padding: Dimensions.paddingLarge,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingTitleDetails(
                title: intl.appThemeTitle,
                description: intl.appThemeDescription,
                icon: Icons.light_mode_outlined,
                onTap: () {
                  navigateTo(context, const ThemeView());
                },
              ),
              SettingTitleDetails(
                title: intl.languageTitle,
                description: intl.languageDescription,
                icon: Icons.language_outlined,
                onTap: () {
                  navigateTo(context, const LanguageView());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileUser(BuildContext context) {
    return GlobalUserConsumer(
      builder: (context, user) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ApiImageWidget(
            imageFilename: user.imageFilename,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            isMen: user.isMen,
            hasImageViewer: true,
          ),
          Dimensions.widthMedium,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Dimensions.heightSmall,
                Text(intl.updateProfileDescription),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              navigateTo(
                context,
                const EditProfileView(),
              );
            },
            child: const Icon(
              Icons.border_color_outlined,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return CustomFilledButton(
      widget: Text(
        intl.logout,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.surface,
            ),
      ),
      onPressed: () {
        SessionManager.logout();
      },
    );
  }
}
