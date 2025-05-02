import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_more/class/class_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../../../models/training_center/class/class.dart';

class ClassCard extends StatelessWidget {
  final Class classItem;
  final List<List<Color>> cardGradients = [
    [const Color(0xFF6A11CB), const Color(0xFF2575FC)], // Purple to Blue
    [const Color(0xFF00C6FB), const Color(0xFF005BEA)], // Light Blue to Blue
    [const Color(0xFFFF9A9E), const Color(0xFFFAD0C4)], // Pink to Light Pink
    [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Blue to Purple
  ];

  ClassCard({super.key, required this.classItem});

  String formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String getShortDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get a gradient from the list based on the class ID
    final cardGradient =
        cardGradients[classItem.name.hashCode.toInt() % cardGradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: cardGradient,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardGradient[0].withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            navigateTo(
              context,
              ClassView(classId: classItem.id),
            );
          },
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Class name with icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getIconForClass(classItem.name ?? ''),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        classItem.name ?? 'Unnamed Class',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: Dimensions.heightMedium),

                // Period with calendar icon
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white70,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${getShortDate(classItem.startDate)} - ${getShortDate(classItem.endDate)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Dimensions.heightSmall,
                // Students count with people icon
                Row(
                  children: [
                    const Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${classItem.totalStudents} Students',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Dimensions.heightMedium,
                // Gender distribution bar
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      // Female ratio
                      Expanded(
                        flex: (classItem.femaleRatio * 100).round(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pink[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                              topRight: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.female,
                                color: Colors.pinkAccent,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${classItem.femaleStudentsCount}',
                                style: const TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Male ratio
                      Expanded(
                        flex: (classItem.maleRatio * 100).round(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                              topLeft: Radius.zero,
                              bottomLeft: Radius.zero,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.male,
                                color: Colors.blueAccent,
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${classItem.maleStudentsCount}',
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // View details button
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForClass(String className) {
    final name = className.toLowerCase();
    if (name.contains('math')) return Icons.calculate;
    if (name.contains('computer') || name.contains('programming')) {
      return Icons.computer;
    }
    if (name.contains('history')) return Icons.history_edu;
    if (name.contains('physics')) return Icons.science;
    if (name.contains('chemistry')) return Icons.science;
    if (name.contains('biology')) return Icons.biotech;
    if (name.contains('language') || name.contains('english')) {
      return Icons.language;
    }
    if (name.contains('art')) return Icons.palette;
    if (name.contains('music')) return Icons.music_note;
    return Icons.school;
  }
}
