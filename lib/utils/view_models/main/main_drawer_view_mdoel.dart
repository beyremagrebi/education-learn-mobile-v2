import '../../../core/base/base_view_model.dart';

class MainDrawerViewModel extends BaseViewModel {
  bool _isExpanded = false;

  MainDrawerViewModel(super.context);
  bool get isExpanded => _isExpanded;

  // Toggle the expanded state of the header
  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    update();
  }
}
