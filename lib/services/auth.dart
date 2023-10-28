import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseUser {
  static User? user = auth.currentUser;

  static getCartId() {
    String userId = auth.currentUser?.uid ?? '';
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String cartId = (userId).substring((userId).length - 6, (userId).length) +
        (timeStamp).substring((timeStamp).length - 6, (timeStamp).length);

    return cartId;
  }
}
