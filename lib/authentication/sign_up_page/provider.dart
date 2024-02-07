import 'package:flutter/material.dart';

class GenderProvider with ChangeNotifier {
  String _selectedGender = 'Select';

  String get selectedGender => _selectedGender;

  void setGender(String newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }
}

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _error_message = false;

  bool get isLoading => _isLoading;
  bool get error_message => _error_message;

  void setLoading(bool loading) {
    _isLoading = loading;
    _error_message = error_message;
    notifyListeners();
  }
  void setErrorMessage(bool error_message) {
    _error_message = error_message;
    notifyListeners();
  }
}
