import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _selectedGender = 'Select';
  String _email = '';
  String _phone = '';
  String _name = '';
  String _gender = '';


  bool _isLoading = false;
  bool _errorMessage = false;
  bool _isSearching = false;

  String get selectedGender => _selectedGender;
  String get Email => _email;
  String get Phone => _phone;
  String get Name => _name;
  String get Gender => _gender;

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

  void setSelectedGender(String Gender) {
    _gender = Gender;
    notifyListeners();
  }
  void setEmail(String Email) {
    _email = Email;
    notifyListeners();
  }
  void setPhone(String Phone) {
    _phone = Phone;
    notifyListeners();
  }
  void setName(String Name) {
    _name = Name;
    notifyListeners();
  }



}
