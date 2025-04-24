import 'package:flutter/material.dart';
import 'package:studiffy/models/global/facility.dart';

import '../../../../core/api/errors/dialod_exception.dart';
import '../../../../core/api/services/global/facility_service.dart';
import '../../../../core/localization/loalisation.dart';
import '../user_session/facility_preference.dart';

class SessionFacilityManager {
  static Facility? _facility;
  static Facility get facility => _facility != null
      ? _facility!
      : throw DialogException(intl.sessionUserNull);

  static Future<void> initializeFacility() async {
    final facilityId = await FacilityPreference.shared.load();
    if (facilityId != null) {
      final jsonResponse = await FacilityService.shared.getById(facilityId);
      if (jsonResponse.status) {
        _facility = jsonResponse.resolveData(Facility.fromMap);
      } else {
        throw DialogException('Facility with id $facilityId is not found');
      }
    }
  }

  static Future<void> saveFacility(String? facilityId) async {
    try {
      if (facilityId == null) throw Exception('Facility id is null');

      final jsonResponse = await FacilityService.shared.getById(facilityId);

      if (jsonResponse.data == null) throw Exception(jsonResponse.message);

      _facility = Facility.fromMap(jsonResponse.data);

      final success = await FacilityPreference.shared.save(_facility!.id!);
      if (!success) throw Exception('Could not save facility to the prefs');
    } catch (error, stackTrace) {
      debugPrint('Error saving facility :$error');
      debugPrint(stackTrace.toString());
    }
  }

  static Future<void> resetFacility() async {
    _facility = null;
    await FacilityPreference.shared.reset();
  }
}
