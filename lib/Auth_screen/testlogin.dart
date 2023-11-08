import 'dart:convert';


import 'package:ezye/home_screens/main_screen.dart';
import 'package:ezye/profilescreens/create_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  @override
  void initState() {
    assignValues();
    super.initState();
  }

  void assignValues() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = "https://ezys.in/customerApp/getUser.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      "userId": userId,
    });
    if (response.body.isNotEmpty) json.decode(response.body);
    print(response.body);
    if (json.decode(response.body).isEmpty) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CreateProfile()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
