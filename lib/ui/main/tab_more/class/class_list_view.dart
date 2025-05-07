import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/enums/filter_enums.dart';
import 'package:studiffy/core/extensions/filter_extensions.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_more/class/class_list_view_model.dart';
import 'package:studiffy/ui/main/tab_more/class/widget/shimmer_class_card.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_builder.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../../core/localization/loalisation.dart';
import '../../../../utils/widgets/base/filter_ship_bar.dart';
import '../../../../utils/widgets/custum_input_field.dart';
import 'widget/class_card.dart';

class ClassListView extends StatelessWidget {
  const ClassListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClassListViewModel(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Classes'),
        ),
        body: Consumer<ClassListViewModel>(
          builder: (context, viewModel, child) => BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomInputField(
                      hintText: intl.searchHint,
                      prefixIcon: Icons.search,
                      onChanged: (value) => viewModel.updateSearchQuery(value),
                    ),
                    Dimensions.heightLarge,
                    FilterChipBar<ClassFilter>(
                      filters: ClassFilter.values,
                      viewModel: viewModel,
                      getLabel: (filter) => filter.getLabel(context),
                    ),
                    Dimensions.heightExtraLarge,
                    Expanded(
                      child: AsyncModelListBuilder(
                        viewModel: viewModel,
                        modelList: viewModel.filteredUsers,
                        refreshFunction: viewModel.loadData,
                        loadingWidget: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) =>
                              const ShimmerClassCard(),
                        ),
                        builder: (classes) => GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.70,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            final classItem = classes[index];
                            return ClassCard(classItem: classItem);
                          },
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
