import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/utils/view_models/notifications/notification_view_model.dart';

class GlobalProviders extends StatefulWidget {
  final Widget child;

  const GlobalProviders({
    super.key,
    required this.child,
  });

  @override
  State<GlobalProviders> createState() => GlobalProvidersState();
}

class GlobalProvidersState extends State<GlobalProviders> {
  String userId = '';

  void initialize(String userId) {
    setState(() => this.userId = userId);
  }

  void reset() {
    setState(() => userId = '');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: ObjectKey(userId),
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotificationViewModel(context),
        ),
      ],
      child: widget.child,
    );
  }
}
