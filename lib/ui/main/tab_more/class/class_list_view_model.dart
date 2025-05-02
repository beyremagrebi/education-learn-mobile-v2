import 'package:studiffy/core/api/services/training_center/class_services.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/models/training_center/class/class.dart';

class ClassListViewModel extends BaseViewModel {
  ClassListViewModel(super.context) {
    loadData();
  }

  List<Class>? classes;
  Future<void> loadData() async {
    await makeApiCall(
      fromMapFunction: Class.fromMap,
      apiCall: ClassServices.shared.getClassesByRole(),
      onSuccess: (data) {
        classes = data;
      },
    );
  }
}
