import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/settings/privacy_policy.dart';
import 'package:ezye/settings/return_policy.dart';
import 'package:ezye/settings/terms_and_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoggedIn = false;
  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: apptitle,
        ),
        centerTitle: true,
        leading: const BackButton(color: buttonColor),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
      ),
      body: Column(
        children: [
          if (isLoggedIn == false)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: width / 1.5),
                  SvgPicture.asset('assets/svg/cloud.svg'),
                  const SizedBox(height: 20),
                  const Text(
                    'To access your account, please log in or create a new account.',
                    style: TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(208, 56)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
          if (isLoggedIn == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          side: const BorderSide(
                              width: 1, color: Color(0xffE8E9EE)),
                          minimumSize: const Size(double.infinity, 64)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrivacyPolicy()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Privacy Policy',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Icon(CupertinoIcons.forward, color: Colors.black)
                        ],
                      )),
                  const SizedBox(height: 15),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          side: const BorderSide(
                              width: 1, color: Color(0xffE8E9EE)),
                          minimumSize: const Size(double.infinity, 64)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReturnPolicy()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Return Policy',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Icon(CupertinoIcons.forward, color: Colors.black)
                        ],
                      )),
                  const SizedBox(height: 15),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          side: const BorderSide(
                              width: 1, color: Color(0xffE8E9EE)),
                          minimumSize: const Size(double.infinity, 64)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditions()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terms & Conditions',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Icon(CupertinoIcons.forward, color: Colors.black)
                        ],
                      )),
                  const SizedBox(height: 15),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          side: const BorderSide(
                              width: 1, color: Color(0xffE8E9EE)),
                          minimumSize: const Size(double.infinity, 64)),
                      onPressed: _showDialog,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delete Account',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Icon(CupertinoIcons.forward, color: Colors.black)
                        ],
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            // insetPadding: const EdgeInsets.all(30),
            titlePadding: EdgeInsets.only(top: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Center(
              child: Text(
                'Are you sure?.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            content: const Text(
              'Would you like to delete your account? Confirm to proceed.',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff7C7D85)),
              textAlign: TextAlign.center,
            ),
            actionsPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(double.infinity, 56)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(double.infinity, 56)),
                        onPressed: () {
                          FirebaseAuth.instance.currentUser
                              ?.delete()
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          });
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  )
                ],
              )
            ],
          );
        });
  }
}
