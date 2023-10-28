import 'dart:convert';

import 'package:ezys/model/user.dart';
import 'package:ezys/providers/session_object.dart';
import 'package:ezys/services/api_service.dart';
import 'package:ezys/services/auth.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<void> updateUser() async {
    try {
      Map<String, dynamic> user = SessionObject.user.toJson();
      user['cartId'] = FirebaseUser.getCartId();

      var response = await http.post(
        Uri.parse('${ApiService.url}/editProfile.php'),
        body: user,
      );

      if (response.statusCode == 200 && !jsonDecode(response.body)['error']) {
        // await SharedService.addUserToPref(jsonEncode(reqBody));
        SessionObject.user = UserModel.fromJson(user);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
