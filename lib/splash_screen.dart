import 'dart:async';
import 'dart:convert';

import 'package:ezye/Auth_screen/onboarding_screen.dart';
import 'package:ezye/Auth_screen/testlogin.dart';
import 'package:ezye/model/user.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> listener;
  Future<bool>? getUserFuture;
  bool isUserExists = false;

  @override
  void initState() {
    getUserFuture = getUser();
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
          future: getUserFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              navigateFunction();
              return Center(
                child: Image.asset(
                  'assets/EZYE SS.gif',
                  height: 250,
                  width: 250,
                ),
              );
            }

            if (snapshot.hasError || snapshot.data == false) {
              return const Text("Something went wrong. Please try again later");
            }

            return Center(
              child: Image.asset(
                'assets/EZYE SS.gif',
                height: 250,
                width: 250,
              ),
            );
          }),
    );
  }

  Future<void> navigateFunction() async {
    Timer(const Duration(milliseconds: 2650), () {
      listener = FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const TestLogin()),
          );
        }
      });
    });
  }

  Future<bool> getUser() async {
    try {
      /* PhonePePaymentSdk.init("PRODUCTION", "testAppId", "DIGITALSPONLINE", true)
          .then((val) =>
              {print('**********'), print('PhonePe SDK Initialized - $val')})
          .catchError((error) {
        print(error);
      });*/
      if (FirebaseUser.user?.uid == null) {
        return Future.value(false);
      }

      var getUserUrl = Uri.parse('${ApiService.url}/getUser.php');
      var reqBody = {"userId": FirebaseUser.user?.uid};

      var response = await http.post(getUserUrl, body: reqBody);
      if (response.statusCode == 200) {
        SessionObject.user = UserModel.fromJson(jsonDecode(response.body));
        isUserExists = jsonDecode(response.body)['userId'] != null;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return false;
  }
}
