import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _selectedGender = 'Select';
  bool _isLoading = false;
  bool _errorMessage = false;
  bool _isSearching = false;

  String get selectedGender => _selectedGender;
  bool get isLoading => _isLoading;
  bool get errorMessage => _errorMessage;
  bool get isSearching => _isSearching;

  void setGender(String newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setErrorMessage(bool errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void setSearching(bool searching) {
    _isSearching = searching;
    notifyListeners();
  }
}
