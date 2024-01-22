import 'package:flutter/material.dart';

class CaracteristicProvider with ChangeNotifier {
  int? _selectedDoor;

  int? get selectedDoor => _selectedDoor;

  void updateSelectedDoor(int? value) {
    _selectedDoor = value;
    notifyListeners();
  }

  String? _selectedFuel;
  String? get selectedFuel => _selectedFuel;
  void updateSelectedFuel(String? value) {
    _selectedFuel = value;
    notifyListeners();
  }
}