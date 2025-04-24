import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import 'students/students_view.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('classe name'),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  text: intl.students,
                ),
                Tab(text: intl.subjects),
              ]),
              Dimensions.heightMedium,
              Expanded(
                child: Padding(
                  padding: Dimensions.paddingExtraLargeHorizontal,
                  child: TabBarView(
                    children: [
                      const StudentsView(),
                      Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
