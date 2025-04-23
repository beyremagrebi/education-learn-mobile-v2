import 'package:flutter/material.dart';

import 'loading_widget.dart';

class LoadingScreenView extends StatelessWidget {
  const LoadingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: LoadingWidget()));
  }
}
