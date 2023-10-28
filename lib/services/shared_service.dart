import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static addUserToPref(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  static readUserFromPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user');
  }
}
