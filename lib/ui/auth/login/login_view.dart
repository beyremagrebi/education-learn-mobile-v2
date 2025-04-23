import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/auth/login/login_view_mdoel.dart';

import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/from/buttons/loading_button.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

import '../../../utils/widgets/from/inputs/input_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewMdoel(context),
      child: Consumer<LoginViewMdoel>(
        builder: (context, viewModel, child) => Scaffold(
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
                  if (viewModel.messageError != null)
                    Text(
                      viewModel.messageError ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  Dimensions.heightMedium,
                  Expanded(child: _buildFormLogin(context, viewModel))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoAndWelcomText(BuildContext context) {
    return Column(
      children: [
        ApiImageWidget(
          backgroundColor: Colors.transparent,
          imageFilename: Assets.logoStuddify(context),
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

  Widget _buildFormLogin(BuildContext context, LoginViewMdoel viewModel) {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InputText(
              controller: viewModel.emailController,
              isRequired: true,
              hint: intl.emailHint,
              label: intl.emailLabel,
            ),
            if (viewModel.userExist != null && viewModel.userExist == true) ...[
              Dimensions.heightMedium,
              InputText(
                controller: viewModel.passwordController,
                isRequired: true,
                hint: intl.passwordHint,
                label: intl.passwordLabel,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: viewModel.hidePassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                onSuffixIconTap: viewModel.togglePasswordVisibility,
              ),
            ],
            Dimensions.heightMedium,
            Row(
              children: [
                Expanded(
                  child: CheckboxMenuButton(
                    value: viewModel.rememberMe,
                    onChanged: (value) {
                      viewModel.changeRemmeber(value);
                    },
                    child: Text(
                      intl.rememberMe,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                    child: LoadingButton(
                      isLoading: viewModel.isBusy,
                      onPressed: () {
                        if (viewModel.userExist == null ||
                            viewModel.userExist == null ||
                            viewModel.userExist == false) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            viewModel.checkIsFirstLogin();
                          });
                        } else {
                          viewModel.signIn();
                        }
                      },
                      child: Text(
                        viewModel.userExist == null ||
                                viewModel.userExist == false
                            ? intl.continueButton
                            : intl.loginButton,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
