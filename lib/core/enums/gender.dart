import '../localization/loalisation.dart';

enum Gender {
  male('homme'),
  female('femme'),
  other('autre');

  final String databaseValue;

  const Gender(this.databaseValue);

  String get localized {
    switch (this) {
      case Gender.male:
        return intl.male;
      case Gender.female:
        return intl.female;
      case Gender.other:
        return intl.otherGender;
      default:
        return name;
    }
  }
}
