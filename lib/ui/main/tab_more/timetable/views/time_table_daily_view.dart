import 'package:flutter/material.dart';

import '../../../../../models/training_center/time_table/session.dart';
import '../../../../../utils/time_table_options.dart';

import '../widgets/empty_session.dart';
import '../widgets/session_card.dart';

class TimeTableDailyView extends StatelessWidget {
  final List<Session> sessions;

  const TimeTableDailyView({
    super.key,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const EmptySession();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return SessionCard(
          session: session,
          onTap: () => TimeTableOptions.showSessionDetails(context, session),
        );
      },
    );
  }
}
