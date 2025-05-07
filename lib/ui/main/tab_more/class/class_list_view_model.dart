import 'package:studiffy/core/api/services/training_center/class_services.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/enums/filter_enums.dart';
import 'package:studiffy/models/training_center/class/class.dart';
import 'package:studiffy/utils/view_models/filter_view_model.dart';

class ClassListViewModel extends BaseViewModel
    implements FilterViewModel<ClassFilter> {
  ClassListViewModel(super.context) {
    loadData();
  }

  List<Class>? classes;
  String _searchQuery = '';

  final Set<ClassFilter> _selectedFilters = {};
  Future<void> loadData() async {
    classes = null;
    await makeApiCall(
      fromMapFunction: Class.fromMap,
      apiCall: ClassServices.shared.getClassesByRole(),
      onSuccess: (data) {
        classes = data;
      },
    );
  }

  List<Class>? get filteredUsers {
    if (classes == null) return null;

    Iterable<Class> filtered = classes!;
    final maxInstructorCount =
        filtered.map((c) => c.instructorCount).fold(0, (a, b) => a > b ? a : b);
    final maxStudentsCount =
        filtered.map((c) => c.totalStudents).fold(0, (a, b) => a > b ? a : b);
    if (_selectedFilters.isNotEmpty &&
        !_selectedFilters.contains(ClassFilter.all)) {
      filtered = filtered.where((classe) {
        if (_selectedFilters.contains(ClassFilter.moreMale) &&
            classe.maleStudentsCount > classe.femaleStudentsCount) {
          return true;
        }
        if (_selectedFilters.contains(ClassFilter.moreFemale) &&
            classe.maleStudentsCount < classe.femaleStudentsCount) {
          return true;
        }
        if (_selectedFilters.contains(ClassFilter.moreInstructors) &&
            classe.instructorCount == maxInstructorCount) {
          return true;
        }
        if (_selectedFilters.contains(ClassFilter.moreStudents) &&
            classe.totalStudents == maxStudentsCount) {
          return true;
        }

        return false;
      });
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where(
        (classe) => (classe.name ?? '').toLowerCase().contains(_searchQuery),
      );
    }

    return filtered.toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    update();
  }

  @override
  bool isFilterSelected(ClassFilter filter) {
    return _selectedFilters.contains(filter);
  }

  @override
  void toggleFilter(ClassFilter filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    update();
  }
}
