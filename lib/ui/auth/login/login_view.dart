import 'package:flutter/material.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';

import 'package:studiffy/ui/main/main_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

import '../../../utils/widgets/from/buttons/custum_filled_button.dart';
import '../../../utils/widgets/from/inputs/input_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(intl.signInTitle),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: Padding(
          padding: Dimensions.paddingMedium,
          child: Column(
            children: [
              _buildLogoAndWelcomText(context),
              Dimensions.heightLarge,
              Expanded(child: _buildFormLogin(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoAndWelcomText(BuildContext context) {
    return Column(
      children: [
        const ApiImageWidget(
          backgroundColor: Colors.transparent,
          imageFilename: Assets.logoPstcLight,
          width: 120,
          isAsset: true,
          fit: BoxFit.contain,
        ),
        Text(
          intl.welcomeBack,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 37.0,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        Text(intl.signInToContinue,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ))
      ],
    );
  }

  Widget _buildFormLogin(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputText(
                  controller: TextEditingController(),
                  isRequired: true,
                  hint: intl.emailHint,
                  label: intl.emailLabel,
                ),
                Dimensions.heightMedium,
                InputText(
                  controller: TextEditingController(),
                  isRequired: true,
                  hint: intl.passwordHint,
                  label: intl.passwordLabel,
                ),
                Dimensions.heightMedium,
                Row(
                  children: [
                    // Expanded(
                    //   child: CheckboxMenuButton(
                    //     value: true,
                    //     onChanged: null,
                    //     child: Text(
                    //       'Remember me',
                    //       style: AppTheme.textTheme.titleSmall,
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          Scaffold(
                            appBar: AppBar(
                              title: Text(intl.forgotPasswordTitle),
                            ),
                          ),
                        );
                      },
                      child: Text(intl.forgotPassword,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              )),
                    ),
                  ],
                ),
                Dimensions.heightMedium,
                Center(
                    child: SizedBox(
                  width: double.maxFinite,
                  child: CustomFilledButton(
                    text: intl.loginButton,
                    onPressed: () {
                      navigateToDeleteTree(context, const MainView());
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
