import 'package:studiffy/core/base/base_view_model.dart';

class ImageFileViewModel extends BaseViewModel {
  int _currentImageIndex;

  ImageFileViewModel(super.context, {int initialPage = 0})
      : _currentImageIndex = initialPage;

  int get currentImageIndex => _currentImageIndex;

  void updateImageIndex(int newIndex) {
    _currentImageIndex = newIndex;
    update();
  }
}
