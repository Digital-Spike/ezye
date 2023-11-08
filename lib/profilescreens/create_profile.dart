// ignore_for_file: use_build_context_synchronously

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final user = FirebaseAuth.instance.currentUser;
  late String? _phone;
  var name = TextEditingController();
  var email = TextEditingController();
  var refferal = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (name.text.isEmpty && email.text.isEmpty && _phone!.isEmpty) {
        return;
      }

      _saveUserData();
    } else {}
  }

  @override
  void initState() {
    _phone = user!.phoneNumber?.replaceFirst('+91', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff040707),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                minimumSize: const Size(double.infinity, 56)),
            onPressed: _submitForm,
            child: const Text(
              'Create Account',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enhance your shopping experience',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffBDC1CA)),
                  ),
                  const Text(
                    'Create your\naccount in EZYE',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Profile Picture',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/png/user.png')),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 1.5, color: const Color(0xffE8E9EE))),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: subtitle,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: name,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xffBDC1CA)),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffE8E9EE)),
                            child: const Text(
                              '+91',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              initialValue: _phone ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffE8E9EE),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7C7D85)),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email",
                        style: subtitle,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.phone,
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
                      const SizedBox(height: 15),
                      const Text(
                        "Refferal Code",
                        style: subtitle,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: refferal,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter refferal code',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(height: 20)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = "https://ezys.in/customerApp/addUser.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      "userId": userId,
      "name": name.text,
      "email": email.text,
      "mobile": _phone?.replaceFirst("", "+91"),
      'refferal': refferal.text
    });

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (context, a, b) => const HomePage()),
        (route) => false,
      );
      const snackdemo = SnackBar(
        content: Text("Created successfully.."),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      print('User data saved successfully');
    } else {
      print('Failed to save user data: ${response.statusCode}');
    }
  }
}
