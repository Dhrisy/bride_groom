import 'dart:io';

import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  String _selectedGender = '';
  String _email = '';
  String _phone = '';
  String _name = '';
  String _gender = '';
  File? _photo;
  String _dob = ''; // Nullable DateTime for date of birth
  String _user_id = '';
  String _filterOption = '';
  String _hgt = '';
  String _wgt = '';




  bool _isLoading = false;
  bool _isFav = false;

  bool _errorMessage = false;
  bool _isSearching = false;
  String Searching = '';
  String _search = ''; // Corrected variable name
  bool _isFilter = false;




  String get selectedGender => _selectedGender;
  String get Email => _email;
  String get Search => _search;
  String get search => _search;
  String get FilterOption => _filterOption;
  String get Hgt => _hgt;
  String get Wgt => _wgt;



  String get Phone => _phone;
  String get Name => _name;
  String get Gender => _gender;
  File? get Photo => _photo;
  String? get dob => _dob; // Getter for date of birth
  String get UserId => _user_id;


  bool get isLoading => _isLoading;
  bool get isFav => _isFav;

  bool get errorMessage => _errorMessage;
  bool get isSearching => _isSearching;
  bool get isFilter => _isFilter;


  void setHeight(String Hgt) {
    _hgt = Hgt;
    notifyListeners();
  }

  void setWeght(String Wgt) {
    _wgt = Wgt;
    notifyListeners();
  }


  void setFilterOption(String FilterOption) {
    _filterOption = FilterOption;
    notifyListeners();
  }

  void setFav(bool isFav) {
    _isFav = isFav;
    notifyListeners();
  }


  void setFilter(bool isFilter) {
    _isFilter = isFilter;
    notifyListeners();
  }

  void setSearch(String searching) {
    _search = searching;
    notifyListeners();
  }


  void setGender(String newGender) {
    _selectedGender = newGender;
    notifyListeners();
  }

  void setUserId(String UserId) {
    _user_id = UserId;
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

  void setPhoto(String Photo) {
    _photo = File(Photo);
    notifyListeners();
  }

  void setDob(String dob) {
    _dob = dob;
    notifyListeners();
  }

  void resetFilter(){
    _filterOption = '';

  }

  void clearData() {
    // Reset or clear all the provider data when logging out
    _photo = null;
    _name = '';
    _dob = '';
    _email = '';
    _gender = '';
    _phone = '';
    _selectedGender = 'null';
    _wgt='';
    _hgt = '';
    _filterOption = '';
    _isSearching = false;
    _errorMessage = false;
    _isFilter = false;
    _isLoading = false;
    _search = '';
    _user_id = '';
    notifyListeners();
  }
}
