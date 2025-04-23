import 'package:studiffy/core/base/base_prefernces.dart';
import 'package:studiffy/core/constant/constant.dart';

class FacilityPreference extends BasePreference<String> {
  // SINGLETON ----------------------------------------------------------------

  static final FacilityPreference _instance = FacilityPreference._();

  static FacilityPreference get shared => _instance;

  FacilityPreference._();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get key => facilitySessionPreferenceKey;
}
