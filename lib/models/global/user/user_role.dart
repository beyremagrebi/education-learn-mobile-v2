import 'package:studiffy/core/localization/loalisation.dart';

enum UserRole {
  superAdmin('super-admin'),
  companyAdmin('company-admin'),
  collaborator('utilisateur'),
  commercial('commercial'),
  instructor('instructor'),
  responsible('responsable'),
  student('student'),

  // Deprecated roles
  admin('admin'),
  editor('editor');

  final String databaseValue;

  const UserRole(this.databaseValue);

  String get localized {
    switch (this) {
      case superAdmin:
        return intl.superAdmin;
      case companyAdmin:
        return intl.companyAdmin;
      case collaborator:
        return intl.collaborator;
      case commercial:
        return intl.commercial;
      case instructor:
        return intl.instructor;
      case responsible:
        return intl.responsible;
      case student:
        return intl.student;
      default:
        return name;
    }
  }
}
