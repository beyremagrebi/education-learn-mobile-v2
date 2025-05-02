import 'package:flutter/material.dart';

import 'package:studiffy/core/constant/assets.dart';

import '../../../utils/widgets/background_image_safe_area.dart';

class ChatMainView extends StatelessWidget {
  const ChatMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImageSafeArea(
      svgAsset: Assets.bgMain,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(tabs: [
              Tab(
                text: 'Private',
              ),
              Tab(
                text: 'Group',
              ),
            ]),
            Expanded(
                child: TabBarView(children: [
              Container(),
              Container(),
            ]))
          ],
        ),
      ),
    );
  }
}
