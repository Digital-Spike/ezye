import 'package:ezye/model/user.dart';
import 'package:flutter/cupertino.dart';

class SessionObject extends ChangeNotifier {
  UserModel user = UserModel();

  void updateCartCount({String count = "0"}) {
    user.cartItemCount = count;
    notifyListeners();
  }

  void updateUser({required UserModel userObject} ){
    user = userObject;
    notifyListeners();
  }
}
