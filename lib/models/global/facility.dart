import 'package:studiffy/core/api/errors/dialod_exception.dart';
import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/global/scholirty_config/training_center_config.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

import '../../core/base/base_model.dart';
import '../../core/enums/facility_type.dart';

class Facility extends BaseModel {
  String name;
  String? taxNumber;
  FacilityType type;
  TrainingCenterConfig? scholarshipConfigId;
  String? entreprise;

  @override
  String? get mainAttribute => name;

  Facility({
    required super.id,
    required this.name,
    this.taxNumber,
    this.entreprise,
    required this.type,
    this.scholarshipConfigId,
  });

  bool get isTrainingCenter => type == FacilityType.trainingCenter;

  Facility.fromId(
    String? id, {
    this.name = 'unknown-facility',
    this.type = FacilityType.unspecified,
  }) : super(id: id);

  factory Facility.fromMap(map) {
    if (map is String) return Facility.fromId(map);
    final parsedType = FromJson.enumValue(map['type'], FacilityType.values);

    if (parsedType == null) {
      SessionManager.logout(
          errorAlertText: 'Unknown facility type: ${map['type']}');
      throw DialogException('Unknown facility type: ${map['type']}');
    }

    return Facility(
      id: FromJson.string(map['_id']),
      name: FromJson.string(map['name']) ?? 'unknown-facility',
      taxNumber: FromJson.string(map['serialNumber']),
      entreprise: FromJson.string(map['enterpriseId']),
      type: parsedType,
      scholarshipConfigId: FromJson.model(
          map['scholarityConfigId'], TrainingCenterConfig.fromMap),
    );
  }

  @override
  Map<String, Object> toMap() {
    final map = <String, Object>{};

    map.add('_id', id);
    map.add('facilityName', name);
    map.add('facilitySerialNumber', taxNumber);
    map.add('facilityType', type.databaseValue);
    map.add('scholarityConfigId', scholarshipConfigId);

    return {};
  }
}
