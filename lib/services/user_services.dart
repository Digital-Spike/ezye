import 'dart:convert';

import 'package:ezys/model/user.dart';
import 'package:ezys/providers/session_object.dart';
import 'package:ezys/services/api_service.dart';
import 'package:ezys/services/auth.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<void> updateUser(UserModel user) async {
    try {
      var reqBody = {
        'mobile': user.mobile,
        'email': user.email,
        'name': user.name,
        'cartId': FirebaseUser.getCartId(),
        'userId': user.userId
      };

      var response = await http.post(
        Uri.parse('${ApiService.url}/editProfile.php'),
        body: reqBody,
      );

      if (response.statusCode == 200 && !jsonDecode(response.body)['error']) {
        // await SharedService.addUserToPref(jsonEncode(reqBody));
        SessionObject.user = UserModel.fromJson(reqBody);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
