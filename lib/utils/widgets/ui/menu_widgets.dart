import 'package:flutter/material.dart';
import 'package:studiffy/utils/widgets/main/menu.dart';

import '../../../core/style/dimensions.dart';

import '../../navigator_utils.dart';

class MenuWidget extends StatelessWidget {
  final Menu? menu;
  final double height;
  final double? iconSize;
  final double textScaleFactor;

  const MenuWidget({
    super.key,
    required this.menu,
    required this.height,
    this.iconSize,
    this.textScaleFactor = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (menu == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => menu!.materialPage != null
          ? navigateTo(context, menu!.materialPage!)
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimensions.l),
        width: double.maxFinite,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: Dimensions.largeBorderRadius,
        ),
        child: Stack(
          children: [
            Image.asset(
              menu!.backgroundAsset,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.only(
                top: Dimensions.m,
                left: Dimensions.l,
                right: Dimensions.l,
              ),
              child: Text(
                key: menu?.key,
                menu!.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: Dimensions.paddingLarge,
              child: Icon(
                menu!.icon,
                size: iconSize ?? 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
