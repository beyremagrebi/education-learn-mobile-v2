import 'package:studiffy/core/api/api_response.dart';
import 'package:studiffy/core/api/services/base_service.dart';
import 'package:studiffy/core/api/utils/pagination_response.dart';
import 'package:studiffy/models/global/study_material.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

import '../../../config/env.dart';
import '../../api_service.dart';

class LessonServices extends BaseService<Lesson> {
  // SINGLETON ----------------------------------------------------------------

  static final LessonServices _instance = LessonServices._internal();

  static LessonServices get shared => _instance;

  LessonServices._internal();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get apiUrl => '$baseUrl/$institution';

  @override
  Lesson Function(dynamic map) get fromMapFunction => Lesson.fromMap;

  @override
  Future<ApiResponse<List<Lesson>>> getAll() async {
    return await ApiService.call(
      url: '$apiUrl/get-all-lessons',
      httpMethod: HttpMethod.get,
      queryParameters: SessionManager.valueByRole(
        companyAdmin: {},
        superAdmin: {},
        collaborator: {},
        instructor: {
          'instructorId': SessionManager.user.id,
        },
        student: {
          'classeId': SessionManager.user.classe?.id,
        },
        responsible: {},
      ),
    );
  }

  Future<ApiResponse<PaginatedResponse<Lesson>>> getPaginationLessonBySubject(
    String? subjectId,
  ) async {
    return await ApiService.call(
      url: '$apiUrl/get-all-new-lessons-pagination/$subjectId',
      httpMethod: HttpMethod.get,
    );
  }

  Future<ApiResponse<PaginatedResponse<Lesson>>> getPaginationLessonWithFiltre(
    String? classId,
  ) async {
    return await ApiService.call(
      url: '$apiUrl/get-all-new-lessons-by-class/$classId',
      httpMethod: HttpMethod.get,
    );
  }

  Future<ApiResponse<List<Lesson>>> getLessonByClass(
    String? classId,
  ) async {
    return await ApiService.call(
      url: '$apiUrl/get-all-new-lessons-by-class/$classId',
      httpMethod: HttpMethod.get,
    );
  }

  Future<ApiResponse<List<StudyMaterial>>> getResourceBySubject(
    String? subjectId,
  ) async {
    return await ApiService.call(
      url: '$apiUrl/get-all-study-materials-by-subject/$subjectId',
      httpMethod: HttpMethod.get,
      dataKey: 'data',
    );
  }
}
