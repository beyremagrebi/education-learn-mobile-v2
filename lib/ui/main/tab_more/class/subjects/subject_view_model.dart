import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/models/training_center/subject.dart';
import 'package:studiffy/ui/main/tab_more/class/class_view_model.dart';

class SubjectViewModel extends BaseViewModel {
  ClassViewModel viewModel;
  SubjectViewModel(super.context, {required this.viewModel});
  String _searchQuery = '';

  List<Subject>? get filteredSubjects {
    if (viewModel.subjectList == null) return null;

    Iterable<Subject> filtered = viewModel.subjectList!;
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where(
        (student) => (student.name ?? '').toLowerCase().contains(_searchQuery),
      );
    }

    return filtered.toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    update();
  }
}
