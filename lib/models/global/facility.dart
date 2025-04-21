import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/extensions/extensions.dart';

import '../../core/base/base_model.dart';
import '../../core/enums/facility_type.dart';

class Facility extends BaseModel {
  String name;
  String? taxNumber;
  FacilityType type;
  String scholarshipConfigId;
  String? entreprise;

  @override
  String? get mainAttribute => name;

  Facility({
    required super.id,
    required this.name,
    this.taxNumber,
    this.entreprise,
    required this.type,
    this.scholarshipConfigId = '',
  });

  bool get isTrainingCenter => type == FacilityType.trainingCenter;

  Facility.fromId(
    String? id, {
    this.name = 'unknown-facility',
    this.scholarshipConfigId = '',
    this.type = FacilityType.unspecified,
  }) : super(id: id);

  factory Facility.fromMap(map) {
    if (map is String) return Facility.fromId(map);

    return Facility(
      id: FromJson.string(map['_id']),
      name: FromJson.string(map['name']) ?? 'unknown-facility',
      taxNumber: FromJson.string(map['serialNumber']),
      entreprise: FromJson.string(map['enterpriseId']),
      type: FromJson.enumValue(map['type'], FacilityType.values) ??
          FacilityType.unspecified,
      scholarshipConfigId: FromJson.string(map['scholarityConfigId']) ?? '',
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
