import '../constant/assets.dart';

enum FacilityType {
  trainingCenter('centreDeFormation', 'training-company', Assets.typeTc),
  unspecified('unknown-facility', 'unknown-facility', Assets.typeTc);

  final String databaseValue;
  final String endpoint;
  final String assetPath;

  const FacilityType(this.databaseValue, this.endpoint, this.assetPath);

  String get localized {
    switch (this) {
      case trainingCenter:
        return 'Training Center';
      default:
        return name;
    }
  }
}
