import 'package:flutter/material.dart';
import 'package:studiffy/core/base/base_view_model.dart';

class TabViewModel extends BaseViewModel {
  ScrollController scrollController = ScrollController();

  bool isScrollingDown = false;

  void scrollListener() {
    if (scrollController.offset > 0 && !isScrollingDown) {
      isScrollingDown = true;
      update();
    } else if (scrollController.offset <= 0 && isScrollingDown) {
      isScrollingDown = false;
      update();
    }
  }

  TabViewModel(super.context) {
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
