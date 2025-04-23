import 'package:flutter/material.dart';

import 'package:studiffy/models/global/user/user.dart';

class ProfileViewModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void updateUser(User newUser) {
    _user = newUser;
    _user?.imageFilename = newUser.imageFilename;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  ProfileViewModel() {
    debugPrint('-- INITIALIZING USER RELATED VIEW MODELS --');
  }
}
