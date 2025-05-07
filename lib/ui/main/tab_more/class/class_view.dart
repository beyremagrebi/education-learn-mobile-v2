import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_course/lesson_list_vew.dart';
import 'package:studiffy/ui/main/tab_more/class/class_view_model.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_builder.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/shimmer/shimmer_text.dart';

import 'students/students_view.dart';
import 'subjects/subject_view.dart';

class ClassView extends StatelessWidget {
  final String? classId;
  const ClassView({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClassViewModel(context, classId: classId),
      child: Consumer<ClassViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: AsyncModelBuilder(
              viewModel: viewModel,
              model: viewModel.classe,
              isEmpty: viewModel.classe == null,
              loadingWidget:
                  const ShimmerText.rectangular(width: 80, height: 20),
              builder: (classe) => Text(classe.name ?? intl.undefined),
              refreshFunction: () => viewModel.loadClass(classId),
            ),
          ),
          body: BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Tab(text: intl.students),
                    Tab(text: intl.subjects),
                    Tab(text: intl.lesson)
                  ]),
                  Dimensions.heightMedium,
                  Expanded(
                    child: Container(
                      margin: Dimensions.paddingExtraLargeHorizontal,
                      child: TabBarView(
                        children: [
                          StudentsView(
                            viewModel: viewModel,
                          ),
                          SubjectView(
                            viewModel: viewModel,
                          ),
                          LessonListVew(
                            classId: classId,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
