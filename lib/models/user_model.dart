import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _role = 'user';
  bool _isLoggedIn = false;

  String get role => _role;
  bool get isLoggedIn => _isLoggedIn;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void login(String role) {
    _isLoggedIn = true;
    _role = role;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _role = 'user';
    notifyListeners();
  }
}
