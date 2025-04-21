import 'package:flutter/cupertino.dart';

class Menu {
  final Key? key;
  final String title;
  final String backgroundAsset;
  final IconData icon;
  final Widget? materialPage;

  Menu({
    this.key,
    required this.title,
    required this.backgroundAsset,
    required this.icon,
    required this.materialPage,
  });
}
