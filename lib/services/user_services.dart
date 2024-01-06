import 'package:ezye/model/user.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  static Future<void> updateUser({required BuildContext context}) async {
    try {
      Map<String, dynamic> user =
          Provider.of<SessionObject>(context, listen: false).user.toJson();
      user['cartId'] = FirebaseUser.getCartId();

      var response = await http.post(
        Uri.parse('${ApiService.url}editProfile.php'),
        body: user,
      );

      if (response.statusCode == 200) {
        // await SharedService.addUserToPref(jsonEncode(reqBody));
        Provider.of<SessionObject>(context, listen: false).user =
            UserModel.fromJson(user);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
