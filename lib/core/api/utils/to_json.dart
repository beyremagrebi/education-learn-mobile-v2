import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../base/base_model.dart';

class ToJson {
  static String? date<T>(DateTime? dateTime) {
    if (dateTime == null) return null;

    try {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $dateTime');
        print(stackTrace);
      }

      return null;
    }
  }

  static String? time<T>(DateTime? dateTime) {
    if (dateTime == null) return null;

    try {
      return DateFormat('HH:mm').format(dateTime);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $dateTime');
        print(stackTrace);
      }

      return null;
    }
  }

  static String? timeOfDay<T>(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;

    try {
      return '${timeOfDay.hour}:${timeOfDay.minute}';
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $timeOfDay');
        print(stackTrace);
      }

      return null;
    }
  }

  static dynamic model<Model extends BaseModel>(Model? model) {
    try {
      return model?.toMap();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $model');
        print(stackTrace);
      }

      return null;
    }
  }

  static dynamic modelList<Model extends BaseModel?>(
    List<Model>? typeList, {
    Map<String, dynamic> Function(Model model)? customToMap,
  }) {
    try {
      return typeList
          ?.map((e) => customToMap != null ? customToMap(e) : e?.toMap())
          .toList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $typeList');
        print(stackTrace);
      }

      return null;
    }
  }

  static dynamic enumList<Enum>(List<dynamic>? enumList) {
    try {
      return enumList?.map((e) => e.databaseValue).toList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e : $enumList');
        print(stackTrace);
      }

      return null;
    }
  }

  static String getPrettyJSONString(dynamic jsonObject) {
    var encoder = const JsonEncoder.withIndent('     ');
    return encoder.convert(jsonObject);
  }
}
