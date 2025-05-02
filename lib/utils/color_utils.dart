import 'package:flutter/material.dart';

class ColorUtils {
  // Private constructor to prevent instantiation
  ColorUtils._();

  /// Returns a consistent color for a given subject name
  static Color getSubjectColor(String subjectName) {
    final int hash = subjectName.hashCode.abs();
    final List<Color> colors = _getSubjectColors();
    return colors[hash % colors.length];
  }

  /// Returns the list of available subject colors
  static List<Color> _getSubjectColors() {
    return [
      Colors.blue.shade700,
      Colors.purple.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.pink.shade700,
      Colors.teal.shade700,
      Colors.indigo.shade700,
      Colors.red.shade700,
    ];
  }

  /// Returns a contrasting text color for a given background color
  static Color getContrastTextColor(Color backgroundColor) {
    // Calculate the luminance of the background color
    final double luminance = backgroundColor.computeLuminance();
    // Use white text for dark backgrounds and black for light
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
