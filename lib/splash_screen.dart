import 'dart:async';
import 'dart:convert';

import 'package:ezys/Auth_screen/add_user.dart';
import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/home_screens/home_screen.dart';
import 'package:ezys/services/api_service.dart';
import 'package:ezys/services/auth.dart';
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
  Future<void>? getUserFuture;
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
      body: FutureBuilder<void>(
          future: getUserFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
              builder: (context) => const LoginPage(),
            ),
          );
        } else {
          isUserExists
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AddUser()),
                );
        }
      });
    });
  }

  Future<void> getUser() async {
    try {
      if (FirebaseUser.user?.uid == null) {
        return;
      }

      var getUserUrl = Uri.parse('${ApiService.url}/getUser.php');
      var reqBody = {"userId": FirebaseUser.user?.uid};

      var response = await http.post(getUserUrl, body: reqBody);
      if (response.statusCode == 200) {
        isUserExists = jsonDecode(response.body)['userId'] != null;
        navigateFunction();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
