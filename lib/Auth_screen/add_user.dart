import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/model/user.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String verificationID = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                  top: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[400]),
                      child: const Icon(CupertinoIcons.clear),
                    ),
                  )),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                        child: Text(
                      'Create Your Account Now',
                      style: apptitle,
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    Stack(
                      children: [
                        const Center(
                          child: CircleAvatar(
                            minRadius: 55,
                            child: Icon(
                              CupertinoIcons.person,
                              size: 60,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 200,
                            right: 120,
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Colors.grey,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/icons/Edit (1).svg',
                                  height: 20,
                                  width: 20,
                                )))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: subtitle,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Name',
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Phone Number",
                            style: subtitle,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            enabled: false,
                            initialValue:
                                FirebaseAuth.instance.currentUser?.phoneNumber,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Phone Number',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Email",
                            style: subtitle,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Enter Your Email',
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                minimumSize: const Size(double.infinity, 45),
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;
                              await addUser();
                              if (mounted) {
                                Navigator.pushAndRemoveUntil<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const HomePage()),
                                  ModalRoute.withName('/'),
                                );
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      var reqBody = {
        'userId': userId,
        'name': name.text,
        'email': email.text,
        'mobile': FirebaseAuth.instance.currentUser?.phoneNumber,
        'cartId': FirebaseUser.getCartId()
      };

      var response = await http.post(
        Uri.parse('${ApiService.url}/addUser.php'),
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
