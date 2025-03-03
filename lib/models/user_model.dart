import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _userRole = 'guest';
  bool _isLoggedIn = false;

  String get userRole => _userRole;
  bool get isLoggedIn => _isLoggedIn;

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }

  void login(String role) {
    _isLoggedIn = true;
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userRole = 'guest';
    notifyListeners();
  }

}
