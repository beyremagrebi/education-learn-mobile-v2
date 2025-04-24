import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../base/base_model.dart';

class FromJson {
  static T? _safeJsonOperation<T>(dynamic jsonValue, T? Function() operation) {
    try {
      if (jsonValue == null) return null;

      return operation();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('$e');
        print(
            'Value that failed : $jsonValue of type ${jsonValue.runtimeType}');
        print(stackTrace);
      }
    }
    return null;
  }

  static String? string(dynamic jsonValue) {
    return _safeJsonOperation<String?>(jsonValue, () => jsonValue as String?);
  }

  static bool? boolean(dynamic jsonValue) {
    return _safeJsonOperation<bool?>(jsonValue, () => jsonValue as bool?);
  }

  static int? integer(dynamic jsonValue) {
    return _safeJsonOperation<int?>(jsonValue, () => jsonValue as int?);
  }

  static double? doubleValue(dynamic jsonValue) {
    return _safeJsonOperation<double?>(
      jsonValue,
      () => jsonValue == null ? null : double.tryParse(jsonValue!.toString()),
    );
  }

  static Model? model<Model extends BaseModel>(
    dynamic jsonValue,
    Model Function(dynamic) fromMapFunction,
  ) {
    return _safeJsonOperation<Model?>(
      jsonValue,
      () => fromMapFunction(jsonValue),
    );
  }

  static List<Model>? modelList<Model extends BaseModel>(
    dynamic jsonValue,
    Model Function(dynamic) fromMapFunction,
  ) {
    return _safeJsonOperation<List<Model>?>(
      jsonValue,
      () => List<Model>.from(jsonValue.map((e) => fromMapFunction(e))),
    );
  }

  static TimeOfDay? timeOfDay(dynamic jsonValue) {
    return _safeJsonOperation<TimeOfDay?>(
      jsonValue,
      () {
        final time = jsonValue.toString().split(':');

        return TimeOfDay(
          hour: int.tryParse(time[0]) ?? 0,
          minute: int.tryParse(time[1]) ?? 0,
        );
      },
    );
  }

  static DateTime? dateTime(dynamic jsonValue) {
    return _safeJsonOperation<DateTime?>(
      jsonValue,
      () => DateTime.tryParse(jsonValue),
    );
  }

  static DateTime? dateTimeFromMilliseconds(dynamic jsonValue) {
    return _safeJsonOperation<DateTime?>(
      jsonValue,
      () => DateTime.fromMillisecondsSinceEpoch(
        jsonValue is int ? jsonValue : int.tryParse(jsonValue) ?? 0,
      ),
    );
  }

  static Enum? enumValue<Enum>(dynamic jsonValue, List<Enum> values) {
    if (jsonValue is String && jsonValue.isEmpty) return null;

    return _safeJsonOperation(
      jsonValue,
      () {
        try {
          return values.firstWhere(
            (e) => (e as dynamic).databaseValue == jsonValue,
          );
        } catch (e) {
          debugPrint('Unknown enum value: $jsonValue');
          return null;
        }
      },
    );
  }

  static List<Enum>? enumList<Enum>(dynamic jsonValue, List<dynamic> values) {
    return _safeJsonOperation(
      jsonValue,
      () => List<Enum>.from(
        jsonValue.map((e) => enumValue(e, values)),
      ),
    );
  }

  static List<T>? list<T>(dynamic jsonValue) {
    return _safeJsonOperation(jsonValue, () => List<T>.from(jsonValue));
  }

  static Model? populateModel<Model extends BaseModel>(
    dynamic jsonValue,
    List<Model> values,
  ) {
    return _safeJsonOperation(
      jsonValue,
      () => values.firstWhereOrNull((e) => e.id == jsonValue),
    );
  }

  static List<Model>? populateModelList<Model extends BaseModel>(
    dynamic jsonValue,
    List<Model> modelList,
  ) {
    return _safeJsonOperation<List<Model>?>(jsonValue, () {
      List<Model> elementList = [];

      if (jsonValue is List) {
        for (final element in jsonValue) {
          if (element is String) {
            final matchingModel = modelList.firstWhereOrNull(
              (e) => e.id == element,
            );
            if (matchingModel != null) elementList.add(matchingModel);
          } else if (element is Map) {
            if (element.containsKey('_id')) {
              final matchingModel = modelList.firstWhereOrNull(
                (e) => e.id == element['_id'],
              );
              if (matchingModel != null) elementList.add(matchingModel);
            } else {
              throw Exception(
                "Populate error : Map value does not contain '_id'",
              );
            }
          } else {
            throw Exception(
              'Populate error : List value does not support the type '
              "'${element.runtimeType}'",
            );
          }
        }
      } else {
        throw Exception(
          "Populate error : Json value is invalid '${jsonValue.runtimeType}'",
        );
      }

      return elementList;
    });
  }
}
