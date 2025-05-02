import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';
import 'package:studiffy/ui/main/tab_course/chapter/chapter_details.dart';
import 'package:studiffy/ui/main/tab_course/chapter/chapter_page.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../../../core/localization/loalisation.dart';
import '../../../../../models/training_center/lesson/chapter.dart';

class LessonChaptersSection extends StatefulWidget {
  final Lesson lesson;

  const LessonChaptersSection({super.key, required this.lesson});

  @override
  State<LessonChaptersSection> createState() => _LessonChaptersSectionState();
}

class _LessonChaptersSectionState extends State<LessonChaptersSection> {
  // Initially show only 3 chapters
  static const int initialChapterCount = 3;
  bool _showAllChapters = false;

  Widget _buildChapterItem(Chapter chapter, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => navigateTo(context, ChapterDetailPage(chapter: chapter)),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // File icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.subject,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // File name and info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.title ?? intl.undefined,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      chapter.description ?? intl.undefined,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: !AppTheme.islight
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              Icon(
                Icons.arrow_forward,
                color: !AppTheme.islight
                    ? Colors.blue.shade300
                    : Colors.blue.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowMoreButton(BuildContext context) {
    final remainingCount = widget.lesson.chapters!.length - initialChapterCount;

    return InkWell(
      onTap: () {
        if (remainingCount > 5) {
          navigateTo(context, const ChaptersPage());
        } else {
          setState(() {
            _showAllChapters = true;
          });
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              remainingCount > 5 ? Icons.view_list : Icons.expand_more,
              color: !AppTheme.islight
                  ? Colors.blue.shade300
                  : Colors.blue.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              remainingCount > 5
                  ? '${intl.viewAll} ${widget.lesson.chapters!.length} ${intl.chapters}'
                  : '${intl.showMore} ($remainingCount ${intl.more})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: !AppTheme.islight
                    ? Colors.blue.shade300
                    : Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chapters = widget.lesson.chapters ?? [];
    final displayedChapters = _showAllChapters
        ? chapters
        : chapters.take(initialChapterCount).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: !AppTheme.islight
            ? Colors.grey.shade900.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: !AppTheme.islight
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title with chapter count
          Row(
            children: [
              Icon(
                Icons.book,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.green.shade300
                    : Colors.green.shade700,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${intl.chapters} (${chapters.length})',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                ),
              ),
              InkWell(
                onTap: () => navigateTo(context, const ChaptersPage()),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    intl.filterAll,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: !AppTheme.islight
                              ? Colors.blue.shade300
                              : Colors.blue.shade700,
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          // Chapter list
          ...displayedChapters.map(
            (chapter) => _buildChapterItem(chapter, context),
          ),

          // Show more button if needed
          if (chapters.length > initialChapterCount && !_showAllChapters)
            _buildShowMoreButton(context),

          // Show less button if expanded
          if (_showAllChapters && chapters.length > initialChapterCount)
            InkWell(
              onTap: () {
                setState(() {
                  _showAllChapters = false;
                });
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.expand_less,
                      color: !AppTheme.islight
                          ? Colors.blue.shade300
                          : Colors.blue.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      intl.showLess,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: !AppTheme.islight
                            ? Colors.blue.shade300
                            : Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
