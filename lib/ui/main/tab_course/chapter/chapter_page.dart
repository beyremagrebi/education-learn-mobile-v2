import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import '../../../../models/training_center/lesson/chapter.dart';
import 'chapter_details.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({super.key});

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  late List<Chapter> _chapters;
  bool _isLoading = true;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Completed', 'In Progress'];

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  Future<void> _loadChapters() async {
    setState(() {
      _chapters = getMockChapters();
      _isLoading = false;
    });
  }

  List<Chapter> _getFilteredChapters() {
    final currentUserId = SessionManager.user.id;

    if (_selectedFilter == 'All') {
      return _chapters;
    } else if (_selectedFilter == 'Completed') {
      return _chapters.where((chapter) {
        return chapter.userProgress?.any(
              (progress) =>
                  progress.user?.id == currentUserId &&
                  (progress.isComplete ?? false),
            ) ??
            false;
      }).toList();
    } else {
      // "Incomplete" or any other filter
      return _chapters.where((chapter) {
        return !(chapter.userProgress?.any(
              (progress) =>
                  progress.user?.id == currentUserId &&
                  (progress.isComplete ?? false),
            ) ??
            false);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : BackgroundImageSafeArea(
              svgAsset: Assets.bgMain,
              child: Column(
                children: [
                  _buildAppBar(),
                  _buildCourseProgress(),
                  _buildFilters(),
                  Expanded(child: _buildChaptersList()),
                ],
              ),
            ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: const Text('Course Chapters'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Show more options
          },
        ),
      ],
    );
  }

  Widget _buildCourseProgress() {
    final completedChapters = _chapters
        .where(
          (chapter) =>
              chapter.userProgress?.any(
                (userP) =>
                    userP.user?.id == SessionManager.user.id &&
                    userP.isComplete == true,
              ) ??
              false,
        )
        .length;
    final totalChapters = _chapters.length;
    final progressPercent =
        totalChapters > 0 ? completedChapters / totalChapters : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.shade700,
            Colors.teal.shade900,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          LinearPercentIndicator(
            lineHeight: 8,
            percent: progressPercent,
            backgroundColor: Colors.white.withOpacity(0.2),
            progressColor: Colors.amber,
            barRadius: const Radius.circular(4),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 1000,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$completedChapters of $totalChapters chapters completed',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              Text(
                '${(progressPercent * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                filter,
              ),
              selected: isSelected,
              onSelected: (selected) {
                // Apply filter
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildChaptersList() {
    final filteredChapters = _getFilteredChapters();

    if (filteredChapters.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.book_outlined,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${_selectedFilter.toLowerCase()} chapters found',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredChapters.length,
      itemBuilder: (context, index) {
        final chapter = filteredChapters[index];
        return ChapterCard(
          chapter: chapter,
          onTap: () {
            navigateTo(
              context,
              ChapterDetailPage(chapter: chapter),
            );
          },
        );
      },
    );
  }
}

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _getTypeColor(chapter.type);
    bool isChapterCompleteForUser(Chapter chapter, String? userId) {
      return chapter.userProgress?.any(
            (progress) =>
                progress.user?.id == userId && (progress.isComplete ?? false),
          ) ??
          false;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.islight
            ? Colors.white
            : Colors.grey.shade900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isChapterCompleteForUser(chapter, SessionManager.user.id)
              ? Colors.green.withOpacity(0.5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Position indicator
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        chapter.position.toString(),
                        style: TextStyle(
                          color: typeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Title and type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapter.title ?? intl.undefined,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chapter.type ?? intl.undefined,
                              style: TextStyle(
                                fontSize: 12,
                                color: typeColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Completion status
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isChapterCompleteForUser(
                                chapter, SessionManager.user.id)
                            ? Colors.green
                            : Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isChapterCompleteForUser(
                                chapter, SessionManager.user.id)
                            ? Icons.check
                            : Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                if (chapter.description != null &&
                    chapter.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 48),
                    child: Text(
                      chapter.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 48),
                  child: Row(
                    children: [
                      _buildInfoBadge(
                        Icons.description,
                        '${chapter.studyMaterials?.length} materials',
                        Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoBadge(
                        Icons.quiz,
                        '${chapter.quizzes?.length} quizzes',
                        Colors.purple,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color.withOpacity(0.7),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
          ),
        ),
      ],
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
