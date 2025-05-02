import 'package:flutter/material.dart';
import 'package:studiffy/core/enums/days.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import 'package:studiffy/ui/main/tab_more/timetable/time_table_veiw_model.dart';

import '../../../../../utils/time_table_options.dart';
import '../widgets/weekly_session_card.dart';

class TimeTableWeeklyView extends StatelessWidget {
  final TimeTableVeiwModel viewModel;

  const TimeTableWeeklyView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Dimensions.paddingLarge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'CLASS-TC01',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !AppTheme.islight
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  ),
                  Dimensions.heightSmall,
                  Text(
                    '10 Juin - 16 Juin 2025',
                    style: TextStyle(
                      fontSize: 14,
                      color: !AppTheme.islight
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            Dimensions.heightLarge,

            // Timetable grid
            Container(
              decoration: BoxDecoration(
                color: !AppTheme.islight
                    ? Colors.grey.shade900.withOpacity(0.3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: !AppTheme.islight
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
              ),
              child: Column(
                children: [
                  // Time header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.l),
                    child: Row(
                      children: [
                        // Empty corner
                        SizedBox(
                          width: 60,
                          child: Center(
                            child: Text(
                              'Heure',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        // Day headers
                        ...List.generate(viewModel.days.length, (index) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                viewModel.days[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  // Divider
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: AppTheme.gridLineColor,
                  ),

                  // Time slots
                  ...List.generate(12, (timeIndex) {
                    final hour = 8 + timeIndex;
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Time indicator
                              SizedBox(
                                width: 60,
                                child: Center(
                                  child: Text(
                                    '$hour:00',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                              // Day cells
                              ...List.generate(viewModel.days.length,
                                  (dayIndex) {
                                final day = viewModel.days[dayIndex];
                                final session =
                                    viewModel.findSessionAtTime(day, hour);

                                if (session != null) {
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: WeeklySessionCard(
                                        session: session,
                                        onTap: () =>
                                            TimeTableOptions.showSessionDetails(
                                          context,
                                          session,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.gridLineColor,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        if (timeIndex < 11)
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: AppTheme.gridLineColor,
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
