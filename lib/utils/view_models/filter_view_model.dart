abstract class FilterViewModel<T> {
  bool isFilterSelected(T filter);
  void toggleFilter(T filter);
}
