import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/ui/main/tab_more/class/subjects/widgets/shimmer/shimmer_resource_serction.dart';
import 'package:studiffy/utils/widgets/shimmer/shimmer_text.dart';

import '../../../../../core/constant/assets.dart';
import '../../../../../core/localization/loalisation.dart';
import '../../../../../core/style/dimensions.dart';
import '../../../../../core/style/themes/app_theme.dart';
import '../../../../../utils/widgets/async_widgets/async_model_builder.dart';
import '../../../../../utils/widgets/async_widgets/async_model_list_builder.dart';
import '../../../../../utils/widgets/background_image_safe_area.dart';
import 'subject_details_view_model.dart';
import 'widgets/details/instructor_section.dart';
import 'widgets/details/resource_section.dart';
import 'widgets/details/subject_details_action_button.dart';
import 'widgets/details/subject_header.dart';
import 'widgets/schedule_item.dart';
import 'widgets/shimmer/shimmer_instruction_section.dart';
import 'widgets/shimmer/shimmer_subject_details_header.dart';

class SubjectDetailsView extends StatelessWidget {
  final String? subjectId;
  final Color iconColor;
  const SubjectDetailsView(
      {super.key, required this.subjectId, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          SubjectDetailsViewModel(context, subjectId: subjectId),
      child: Consumer<SubjectDetailsViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: AsyncModelBuilder(
              model: viewModel.subject,
              isEmpty: viewModel.subject == null,
              viewModel: viewModel,
              loadingWidget: const ShimmerText.rectangular(
                height: 20,
                width: 100,
              ),
              builder: (subject) => Text(
                subject.name ?? intl.undefined,
              ),
            ),
          ),
          body: BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Subject header

                AsyncModelBuilder(
                  viewModel: viewModel,
                  model: viewModel.subject,
                  isEmpty: viewModel.subject == null,
                  loadingWidget: const Column(
                    children: [
                      ShimmerSubjectDetailsHeader(),
                      Dimensions.heightHuge,
                    ],
                  ),
                  builder: (subject) {
                    return Column(
                      children: [
                        SubjectHeader(
                          name: subject.name ?? intl.undefined,
                          iconColor: iconColor,
                        ),
                        Dimensions.heightHuge,
                      ],
                    );
                  },
                ),

                AsyncModelBuilder(
                  viewModel: viewModel,
                  model: viewModel.subject,
                  isEmpty: viewModel.subject == null ||
                      viewModel.subject!.instructors.isEmptyOrNull,
                  loadingWidget: const ShimmerInstructionSection(),
                  builder: (subject) {
                    return Column(
                      children: [
                        InstructorSection(
                          instructors: viewModel.subject!.instructors!,
                        ),
                        Dimensions.heightHuge,
                      ],
                    );
                  },
                ),

                // Schedule section
                Text(
                  'Horaire',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Dimensions.heightLarge,
                Container(
                  padding: Dimensions.paddingMedium,
                  decoration: BoxDecoration(
                    color: AppTheme.islight
                        ? Colors.white38
                        : Colors.grey.shade800.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      ScheduleItem(
                        day: 'Lundi',
                        time: '10:00 - 12:00',
                        room: 'Salle A101',
                      ),
                      Divider(height: 24, color: Colors.grey),
                      ScheduleItem(
                        day: 'Mercredi',
                        time: '14:00 - 16:00',
                        room: 'Salle B205',
                      ),
                    ],
                  ),
                ),

                Dimensions.heightHuge,

                // Resources section
                AsyncModelListBuilder(
                  viewModel: viewModel,
                  modelList: viewModel.resourceList,
                  hideIfEmpty: true,
                  refreshFunction: viewModel.loadLesson,
                  loadingWidget: const ShimmerResource(),
                  builder: (resourceList) => Column(
                    children: [
                      ResourceSection(
                        studyMaterials: resourceList,
                      ),
                      Dimensions.heightHuge,
                    ],
                  ),
                ),

                // Action buttons
                const SubjectDetailsActionButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
