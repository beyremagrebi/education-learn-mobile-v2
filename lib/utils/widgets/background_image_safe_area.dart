import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:studiffy/utils/view_models/tab_view_model.dart';

class BackgroundImageSafeArea extends StatelessWidget {
  final String? svgAsset;
  final Widget child;
  final bool safeArea;
  final bool darken;
  final TabViewModel? blurTopBarViewModel;
  final bool animateScale;
  final bool blurSvg;
  final double? opacity;
  final Color? backgroundColor;

  const BackgroundImageSafeArea({
    super.key,
    required this.svgAsset,
    required this.child,
    this.safeArea = true,
    this.darken = false,
    this.blurSvg = true,
    this.blurTopBarViewModel,
    this.animateScale = false,
    this.opacity,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return blurTopBarViewModel != null
        ? ChangeNotifierProvider.value(
            value: blurTopBarViewModel!,
            builder: (context, child) => buildContent(context),
          )
        : buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(context),
        safeArea ? SafeArea(child: child) : child,
        if (!(blurTopBarViewModel?.isDisposed ?? true))
          Consumer<TabViewModel>(
            builder: (context, viewModel, child) => viewModel.isScrollingDown
                ? ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).padding.top,
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.4 // AppTheme.isLight ? 0.7 : 0.4,
                                ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }

  Widget _buildBackground(BuildContext context) {
    if (svgAsset == null) {
      return Container(
          color: backgroundColor ?? Theme.of(context).colorScheme.onSurface);
    }

    try {
      return _buildSvgBackground(context);
    } catch (e) {
      // Fallback if SVG fails to load
      debugPrint('Failed to load SVG: $e');
      return Container(color: backgroundColor ?? Colors.transparent);
    }
  }

  Widget _buildSvgBackground(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 10, end: 50),
      duration: const Duration(milliseconds: 2500),
      curve: Curves.easeInOut,
      builder: (context, value, child) => Stack(
        children: [
          Opacity(
            opacity: opacity ?? 1,
            child: SvgPicture.asset(
              svgAsset!,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
              placeholderBuilder: (context) => Container(
                color: backgroundColor ?? Colors.transparent,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurSvg ? value : 0,
                sigmaY: blurSvg ? value : 0,
              ),
              child: Container(
                color: darken
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
