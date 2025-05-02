import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/media/api_image_widget.dart';

import '../../../../../models/global/user/user.dart';
import 'bar_qode_view.dart';

class StudentDetailsView extends StatelessWidget {
  final User student;

  const StudentDetailsView({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'étudiant'),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile header
              _buildProfileHeader(context),

              const SizedBox(height: 24),

              // Information sections
              _buildInfoSection(
                title: 'Informations personnelles',
                children: [
                  _buildInfoItem(
                    icon: Icons.person,
                    label: 'Nom complet',
                    value:
                        '${student.firstName ?? ''} ${student.lastName ?? ''}',
                  ),
                  _buildInfoItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: student.email ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.wc,
                    label: 'Genre',
                    value: student.gender?.name ?? 'name',
                  ),
                  _buildInfoItem(
                    icon: Icons.cake,
                    label: 'Date de naissance',
                    value: student.birthdate != null
                        ? DateFormat('dd/MM/yyyy').format(student.birthdate!)
                        : 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.location_city,
                    label: 'Lieu de naissance',
                    value: student.birthPlace ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.badge,
                    label: 'CIN',
                    value: student.cin ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.flight,
                    label: 'Passeport',
                    value: student.passport ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.work,
                    label: 'Profession',
                    value: student.occupation ?? 'Non spécifié',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildInfoSection(
                title: 'Coordonnées',
                children: [
                  _buildInfoItem(
                    icon: Icons.phone,
                    label: 'Téléphone',
                    value: student.phoneNumber ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.phone_android,
                    label: 'Téléphone secondaire',
                    value: student.secondaryPhoneNumber ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.language,
                    label: 'Site web',
                    value: student.website ?? 'Non spécifié',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildInfoSection(
                title: 'Adresse',
                children: [
                  _buildInfoItem(
                    icon: Icons.home,
                    label: 'Adresse',
                    value: student.address ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.location_city,
                    label: 'Ville',
                    value: student.city ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.flag,
                    label: 'Pays',
                    value: student.country ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.local_post_office,
                    label: 'Code postal',
                    value: student.postalCode ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.pin_drop,
                    label: 'Code ZIP',
                    value: student.zipCode ?? 'Non spécifié',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildInfoSection(
                title: 'Informations académiques',
                children: [
                  _buildInfoItem(
                    icon: Icons.school,
                    label: 'Classe',
                    value: student.classe?.toString() ?? 'Non assigné',
                  ),
                  _buildInfoItem(
                    icon: Icons.business,
                    label: 'Établissement',
                    value: student.facility?.toString() ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.person_outline,
                    label: 'Rôle',
                    value: student.role?.toString() ?? 'Étudiant',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildInfoSection(
                title: 'Informations bancaires',
                children: [
                  _buildInfoItem(
                    icon: Icons.account_balance,
                    label: 'Banque',
                    value: student.bank ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.credit_card,
                    label: 'RIB',
                    value: student.rib ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.business_center,
                    label: 'Entreprise',
                    value: student.enterprise ?? 'Non spécifié',
                  ),
                  _buildInfoItem(
                    icon: Icons.badge,
                    label: 'Numéro CNSS',
                    value: student.cnssNumber ?? 'Non spécifié',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildInfoSection(
                title: 'Autres informations',
                children: [
                  const BarCodeView(),
                  // _buildInfoItem(
                  //   icon: Icons.qr_code,
                  //   label: 'Code-barres',
                  //   value: student.barcode ?? 'Non spécifié',
                  // ),
                  _buildInfoItem(
                    icon: Icons.tag,
                    label: 'Numéro unique',
                    value: student.uniqueNumber?.toString() ?? 'Non spécifié',
                  ),
                  if (student.description != null &&
                      student.description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.description,
                                  size: 20, color: Colors.grey.shade400),
                              const SizedBox(width: 8),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              student.description!,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 32),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Modifier'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.message),
                      label: const Text('Contacter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Profile image
          ApiImageWidget(
            imageFilename: student.imageFilename,
            width: 120,
            height: 120,
            isMen: student.isMen,
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            '${student.firstName ?? ''} ${student.lastName ?? ''}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            student.email ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Class badge
          if (student.classe != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                student.classe.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.islight
            ? Colors.white38
            : Colors.grey.shade900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.islight
                        ? AppTheme.disabledColor
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
