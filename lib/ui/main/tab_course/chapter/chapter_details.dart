import 'package:flutter/material.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/utils/file_type_utils.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/media/video/video_player_view.dart';

import '../../../../models/global/study_material.dart';
import '../../../../models/training_center/lesson/chapter.dart';
import '../../../../utils/app/session/session_manager.dart';

class ChapterDetailPage extends StatelessWidget {
  final Chapter chapter;

  const ChapterDetailPage({
    super.key,
    required this.chapter,
  });
  bool isChapterCompleteForUser(Chapter chapter, String? userId) {
    return chapter.userProgress?.any(
          (progress) =>
              progress.user?.id == userId && (progress.isComplete ?? false),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _getTypeColor(chapter.type);

    return Scaffold(
      appBar: AppBar(
        title: Text('${intl.chapter} ${chapter.position}'),
        actions: [
          IconButton(
            icon: Icon(
              isChapterCompleteForUser(chapter, SessionManager.user.id)
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: isChapterCompleteForUser(chapter, SessionManager.user.id)
                  ? Colors.green
                  : Colors.grey,
            ),
            onPressed: () {
              // Toggle completion status
            },
          ),
        ],
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chapter header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.islight
                      ? Colors.white
                      : Colors.grey.shade900.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        chapter.type ?? intl.undefined,
                        style: TextStyle(
                          color: typeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Text(
                      chapter.title ?? intl.undefined,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Description
                    if (chapter.description != null &&
                        chapter.description!.isNotEmpty)
                      Text(
                        chapter.description!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade300,
                          height: 1.5,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Study materials section
              if (chapter.studyMaterials.isNotEmptyAndNotNull) ...[
                _buildSectionTitle(
                  intl.studyMaterials,
                  Icons.description,
                  Colors.green,
                  chapter.studyMaterials?.map((material) =>
                          _buildMaterialItem(material, context)) ??
                      [],
                ),
                const SizedBox(height: 24),
              ],

              // Quizzes section
              if (chapter.quizzes.isNotEmptyAndNotNull) ...[
                _buildSectionTitle(
                  intl.quiz,
                  Icons.quiz,
                  Colors.purple,
                  List.generate(chapter.quizzes?.length ?? 0,
                      (index) => _buildQuizItem(index, context)),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, IconData icon, Color iconColor, Iterable<Widget> iterable) {
    return Container(
      padding: Dimensions.paddingMedium,
      decoration: BoxDecoration(
        color: !AppTheme.islight
            ? Colors.grey.shade900.withOpacity(0.5)
            : Colors.white,
        borderRadius: Dimensions.mediumBorderRadius,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: iconColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ...iterable,
        ],
      ),
    );
  }

  Widget _buildMaterialItem(StudyMaterial material, BuildContext context) {
    final IconData iconData =
        FileTypeUtils.getIconForFileName(material.fileName);
    final Color iconColor =
        FileTypeUtils.getColorForFileType(material.fileName);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
      title: Text(material.displayName ?? ''),
      subtitle: Text(
        material.fileName ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade400,
        ),
      ),
      trailing: const Icon(Icons.file_open),
      onTap: () {
        // Open material
        navigateTo(
            context,
            VideoPlayerView(
              url: '$videofileUrl/${material.fileName}',
            ));
      },
    );
  }

  Widget _buildQuizItem(int index, BuildContext context) {
    final bool isCompleted =
        index == 0 && isChapterCompleteForUser(chapter, SessionManager.user.id);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.quiz,
          color: Colors.purple,
        ),
      ),
      title: Text('Quiz ${index + 1}'),
      subtitle: Text(
        isCompleted ? 'Completed' : 'Not attempted',
        style: TextStyle(
          fontSize: 12,
          color: isCompleted ? Colors.green : Colors.grey.shade400,
        ),
      ),
      trailing: Icon(
        isCompleted ? Icons.check_circle : Icons.arrow_forward_ios,
        color: isCompleted ? Colors.green : Colors.grey.shade400,
        size: isCompleted ? 24 : 16,
      ),
      onTap: () {
        // Start quiz
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Starting Quiz ${index + 1}...'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  Color _getTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'video':
        return Colors.red;
      case 'reading':
        return Colors.blue;
      case 'quiz':
        return Colors.purple;
      case 'assignment':
        return Colors.orange;
      case 'discussion':
        return Colors.green;
      default:
        return Colors.teal;
    }
  }
}
