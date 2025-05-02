import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/quiz.dart';

import '../../../../../core/localization/loalisation.dart';

class LessonQuizzesSection extends StatelessWidget {
  final List<Quiz> quizzes;

  const LessonQuizzesSection({super.key, required this.quizzes});

  void _navigateToQuiz(Quiz quiz, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ouverture du quiz: ${quiz.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildQuizItem(Quiz quiz, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _navigateToQuiz(quiz, context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Quiz icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: !AppTheme.islight
                      ? Colors.purple.shade900.withOpacity(0.2)
                      : Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.assignment,
                  color: !AppTheme.islight
                      ? Colors.purple.shade300
                      : Colors.purple.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Quiz info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title ?? intl.undefined,
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
                      '${quiz.questionCount} questions • ${quiz.timeLimit} minutes',
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
              // Status indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: quiz.isCompleted ?? false
                      ? (!AppTheme.islight
                          ? Colors.green.shade900.withOpacity(0.2)
                          : Colors.green.shade50)
                      : (!AppTheme.islight
                          ? Colors.orange.shade900.withOpacity(0.2)
                          : Colors.orange.shade50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  quiz.isCompleted ?? false ? 'Terminé' : 'À faire',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: quiz.isCompleted ?? false
                        ? (!AppTheme.islight
                            ? Colors.green.shade300
                            : Colors.green.shade700)
                        : (!AppTheme.islight
                            ? Colors.orange.shade300
                            : Colors.orange.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          // Section title
          Row(
            children: [
              Icon(
                Icons.quiz,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.purple.shade300
                    : Colors.purple.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Quiz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Quizzes list
          ...quizzes.map((quiz) => _buildQuizItem(quiz, context)),
        ],
      ),
    );
  }
}
