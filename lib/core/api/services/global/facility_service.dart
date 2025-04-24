import 'package:studiffy/models/global/facility.dart';

import '../../../config/env.dart';
import '../../../localization/loalisation.dart';
import '../../api_response.dart';
import '../../api_service.dart';
import '../../errors/dialod_exception.dart';
import '../base_service.dart';

class FacilityService extends BaseService<Facility> {
  // SINGLETON ----------------------------------------------------------------

  static final FacilityService _instance = FacilityService._internal();

  static FacilityService get shared => _instance;

  FacilityService._internal();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get apiUrl => baseUrl;

  @override
  Facility Function(dynamic map) get fromMapFunction => Facility.fromMap;

  @override
  Future<ApiResponse<Facility>> getById(String? id) async {
    if (id == null) throw DialogException(intl.userIdRequired);

    return await ApiService.call(
      url: '$apiUrl/getOneFacility/$id',
      httpMethod: HttpMethod.get,
      dataKey: endpoints.getByIdDataKey,
    );
  }
}
