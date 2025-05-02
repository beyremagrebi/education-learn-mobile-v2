import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

import '../../global/study_material.dart';
import 'quiz.dart';
import 'user_progress.dart';

class Chapter extends BaseModel {
  String? title;
  String? description;
  String? type;
  int? position;
  String? typeDocument;
  String? jsonFiles;
  List<StudyMaterial>? studyMaterials;
  List<Quiz>? quizzes;
  List<UserProgress>? userProgress;

  Chapter({
    required super.id,
    required this.title,
    required this.description,
    this.jsonFiles,
    required this.position,
    required this.studyMaterials,
    required this.quizzes,
    required this.type,
    required this.typeDocument,
    this.userProgress,
  });
  Chapter.fromId(String? id) : super(id: id);

  factory Chapter.fromMap(map) {
    if (map is String) return Chapter.fromId(map);
    return Chapter(
      id: FromJson.string(map['_id']),
      title: FromJson.string(map['title']),
      description: FromJson.string('description'),
      jsonFiles: FromJson.string(map['jsonFiles']),
      position: FromJson.integer(map['position']),
      studyMaterials:
          FromJson.modelList(map['studyMaterials'], StudyMaterial.fromMap),
      quizzes: FromJson.list(map['quizzes']),
      type: FromJson.string(map['type']),
      typeDocument: FromJson.string(map['typeDocument']),
      userProgress:
          FromJson.modelList(map['userProgress'], UserProgress.fromMap),
    );
  }

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

List<Chapter> getMockChapters() {
  return [
    Chapter(
        id: '1',
        title: 'Introduction to Programming',
        description: 'Learn the basics of programming concepts and paradigms.',
        type: 'Video',
        position: 1,
        typeDocument: 'lecture',
        studyMaterials: [
          StudyMaterial(
            displayName: 'Introduction Slides',
            fileName: 'intro_slides.pdf',
          ),
          StudyMaterial(
            displayName: 'Programming Basics',
            fileName: 'programming_basics.docx',
          ),
        ],
        quizzes: [],
        userProgress: [
          UserProgress(id: '1', user: SessionManager.user, isComplete: true),
        ]),
    Chapter(
      id: '2',
      title: 'Variables and Data Types',
      description:
          'Understanding different data types and how to use variables.',
      type: 'Reading',
      position: 2,
      typeDocument: 'lecture',
      studyMaterials: [
        StudyMaterial(
          displayName: 'Data Types Guide',
          fileName: 'data_types.pdf',
        ),
        StudyMaterial(
          displayName: 'Variables Exercise',
          fileName: 'variables_exercise.docx',
        ),
      ],
      quizzes: [],
    ),
    Chapter(
        id: '3',
        title: 'Control Structures',
        description:
            'Learn about if statements, loops, and other control structures.',
        type: 'Video',
        position: 3,
        typeDocument: 'lecture',
        studyMaterials: [
          StudyMaterial(
            displayName: 'Control Structures Video',
            fileName: 'control_structures.mp4',
          ),
          StudyMaterial(
            displayName: 'Practice Problems',
            fileName: 'control_practice.pdf',
          ),
        ],
        quizzes: [],
        userProgress: [
          UserProgress(id: '1', user: SessionManager.user, isComplete: true),
        ]),
    Chapter(
      id: '4',
      title: 'Functions and Methods',
      description:
          'Understanding how to create and use functions in programming.',
      type: 'Assignment',
      position: 4,
      typeDocument: 'assignment',
      studyMaterials: [
        StudyMaterial(
          displayName: 'Functions Guide',
          fileName: 'functions_guide.pdf',
        ),
      ],
      quizzes: [],
    ),
    Chapter(
      id: '5',
      title: 'Object-Oriented Programming',
      description:
          'Introduction to classes, objects, inheritance, and polymorphism.',
      type: 'Reading',
      position: 5,
      typeDocument: 'lecture',
      studyMaterials: [
        StudyMaterial(
          displayName: 'OOP Concepts',
          fileName: 'oop_concepts.pdf',
        ),
        StudyMaterial(
          displayName: 'Class Diagrams',
          fileName: 'class_diagrams.png',
        ),
      ],
      quizzes: [],
    ),
    Chapter(
      id: '6',
      title: 'Data Structures',
      description:
          'Learn about arrays, lists, stacks, queues, and other data structures.',
      type: 'Quiz',
      position: 6,
      typeDocument: 'quiz',
      studyMaterials: [
        StudyMaterial(
          displayName: 'Data Structures Overview',
          fileName: 'data_structures.pdf',
        ),
      ],
      quizzes: [],
    ),
    Chapter(
      id: '7',
      title: 'Algorithms',
      description: 'Introduction to common algorithms and their analysis.',
      type: 'Discussion',
      position: 7,
      typeDocument: 'discussion',
      studyMaterials: [
        StudyMaterial(
          displayName: 'Algorithm Basics',
          fileName: 'algorithm_basics.pdf',
        ),
        StudyMaterial(
          displayName: 'Sorting Algorithms',
          fileName: 'sorting_algorithms.mp4',
        ),
      ],
      quizzes: [
        Quiz(
            id: 'id',
            title: 'title',
            questionCount: 5,
            timeLimit: 5,
            isCompleted: false),
      ],
    ),
  ];
}
