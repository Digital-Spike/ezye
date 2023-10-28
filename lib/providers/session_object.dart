import 'package:ezys/model/user.dart';
import 'package:flutter/cupertino.dart';

class SessionObject extends ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
