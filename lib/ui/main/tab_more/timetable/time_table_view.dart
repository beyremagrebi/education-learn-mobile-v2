import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/ui/main/tab_more/timetable/time_table_veiw_model.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import 'views/time_table_daily_view.dart';
import 'views/time_table_weekly_view.dart';

class TimeTableView extends StatelessWidget {
  const TimeTableView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimeTableVeiwModel(context),
      child: Consumer<TimeTableVeiwModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Emploi du temps'),
            actions: [
              IconButton(
                icon: Icon(
                  viewModel.isWeeklyView ? Icons.view_day : Icons.view_week,
                ),
                onPressed: () {
                  viewModel.toggleWeeklyView();
                },
              ),
            ],
          ),
          body: BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            child: DefaultTabController(
              length: viewModel.days.length,
              child: Column(
                children: [
                  if (viewModel.isWeeklyView)
                    Expanded(
                        child: TimeTableWeeklyView(
                      viewModel: viewModel,
                    ))
                  else ...[
                    TabBar(
                      isScrollable: true,
                      tabs: viewModel.days
                          .map((day) => Tab(text: day.name))
                          .toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: viewModel.days
                            .map(
                              (day) => TimeTableDailyView(
                                sessions: viewModel.getMockSessionsForDay(day),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
