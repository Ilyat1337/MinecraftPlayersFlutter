import 'package:flutter/material.dart';

class LoggedUserModel extends ChangeNotifier {
  String _userId = "";
  String get userId  => _userId;

  void setLoggedUserId(String userId) {
    _userId = userId;
    print("User id changed!");
    notifyListeners();
  }
  
  void logOut() {
    setLoggedUserId("");
  }
}