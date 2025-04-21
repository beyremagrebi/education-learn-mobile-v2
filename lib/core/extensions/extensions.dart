import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension CloseView on BuildContext {
  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}

extension IterableExtension on Iterable? {
  bool get isEmptyOrNull => (this?.isEmpty ?? false);

  bool get isNotEmptyAndNotNull => (this?.isNotEmpty ?? false);
}

extension StringExtension on String? {
  bool get isEmptyOrNull => (this?.isEmpty ?? false);

  bool get isNotEmptyAndNotNull => (this?.isNotEmpty ?? false);
}

extension MapExtension on Map<String, Object> {
  void add(String key, Object? value) {
    if (value != null) this[key] = value;
  }
}
