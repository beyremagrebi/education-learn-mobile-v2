import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/ui/main/tab_more/class/class_view_model.dart';

class StudentsViewModel extends BaseViewModel {
  ClassViewModel viewModel;
  StudentsViewModel(super.context, {required this.viewModel});
  String _searchQuery = '';

  List<User>? get filteredUsers {
    if (viewModel.studetns == null) return null;

    Iterable<User> filtered = viewModel.studetns!;
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where(
        (student) =>
            (student.firstName ?? '').toLowerCase().contains(_searchQuery) ||
            (student.lastName ?? '').toLowerCase().contains(_searchQuery) ||
            (student.email ?? '').toLowerCase().contains(_searchQuery),
      );
    }

    return filtered.toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    update();
  }
}
