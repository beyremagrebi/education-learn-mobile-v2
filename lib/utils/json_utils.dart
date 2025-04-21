import 'dart:convert';

import 'package:flutter/material.dart';

class JsonUtils {
  // Method to format JSON
  static String format(Object? object) {
    try {
      return const JsonEncoder.withIndent('\t').convert(object);
    } catch (e) {
      debugPrint('Error string is not a JSON object');
      // If an error occurs (e.g. it's not valid JSON), return the original string
      return object.toString();
    }
  }
}
