import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseUser {
  static User? user = auth.currentUser;
  static String cartId = (user?.uid ?? "")
      .substring((user?.uid ?? "").length - 6, (user?.uid ?? "").length);
}
