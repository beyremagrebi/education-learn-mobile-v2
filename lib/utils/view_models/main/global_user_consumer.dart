import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/utils/view_models/profile_view_model.dart';

class GlobalUserConsumer extends StatelessWidget {
  final Widget Function(BuildContext context, User user) builder;
  final Widget? loading;

  const GlobalUserConsumer({
    super.key,
    required this.builder,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, session, child) {
        final user = session.user;
        if (user == null) {
          return loading ?? const Center(child: CircularProgressIndicator());
        }
        return builder(context, user);
      },
    );
  }
}
