import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.height,
    this.width,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: SpinKitFadingCube(
          color: color ?? Theme.of(context).colorScheme.primary,
          size: size,
        ),
      ),
    );
  }
}
