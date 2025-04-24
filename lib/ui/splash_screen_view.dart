import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';

import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../core/localization/flutter_localization.dart';
import '../core/style/responsive_dimensions.dart';
import '../core/style/themes/app_colors.dart';

import 'splash_screen_view_mdoel.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    mainOverlayState = Overlay.of(context);
    ResponsiveDimensions.screenWidth = Dimensions.screenWidth(context);
    ResponsiveDimensions.screenHeight = Dimensions.screenHeight(context);

    return ChangeNotifierProvider(
      create: (context) => SplashScreenViewModel(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: BackgroundImageSafeArea(
          svgAsset: Assets.bgMain,
          child: Consumer<SplashScreenViewModel>(
            builder: (context, viewModel, child) => Stack(
              alignment: Alignment.center,
              children: [
                _buildAnimatedLogoWidget(
                    context, viewModel.onAnimationComplete),
                viewModel.hasError
                    ? _buildHasErrorWidget(context, viewModel)
                    : _buildWaitingServerWidget(context, viewModel)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogoWidget(
      BuildContext context, VoidCallback onAnimationComplete) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 3),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, double scale, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 700),
          opacity: scale.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      onEnd: onAnimationComplete,
      child: Padding(
        padding: Dimensions.paddingHugeHorizontal,
        child: Image.asset(
          Assets.logoPstc(context),
          fit: BoxFit.contain,
          alignment: Alignment.center,
          cacheHeight: 150,
          cacheWidth: 580,
        ),
      ),
    );
  }

  Widget _buildWaitingServerWidget(
      BuildContext context, SplashScreenViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.screenHeight(context) / 8,
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: Dimensions.paddingExtraLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                intl.serverInitializing,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Dimensions.heightExtraLarge,
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
              ),
              onPressed: viewModel.cancel,
              child: Text(
                intl.cancelButton,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHasErrorWidget(
      BuildContext context, SplashScreenViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.screenHeight(context) / 8,
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: Dimensions.paddingExtraLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              intl.connectionError,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
            Dimensions.heightLarge,
            TextButton(
              style: FilledButton.styleFrom(
                foregroundColor: dangerColor,
              ),
              onPressed: viewModel.retry,
              child: Text(
                intl.retryButton,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
