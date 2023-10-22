import 'dart:convert';

import 'package:ezys/Auth_screen/add_user.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/home_screens/home_screen.dart';
import 'package:ezys/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  void initState() {
    super.initState();
    checkCurrentUser(); // Check if the user is already logged in
  }

  void checkCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 5,
                  right: 10,
                  child: InkWell(
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(height: 20),
                      Center(
                          child: Image.asset(
                        'assets/login.gif',
                        height: 250,
                      )),
                      const SizedBox(height: 20),
                      const Text('* Log in using Mobile Number', style: title),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Phone Number',
                            prefix: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('+91'),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          } else if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        visible: otpVisibility,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('* Enter OTP', style: title),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: otpController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'OTP',
                                  prefix: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text(''),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter OTP';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 45),
                            backgroundColor: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) return;
                          if (otpVisibility) {
                            verifyOTP();
                          } else {
                            loginWithPhone();
                          }
                        },
                        child: Text(
                          otpVisibility ? "Verify" : "Sign In",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      /*const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "If you don't have account? please",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: indicator,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),*/
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "By continuing, you agree to Ezye's ",
                            style: TextStyle(
                                fontSize: 12.5, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Terms of Use ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: indicator,
                                    fontWeight: FontWeight.bold),
                              )),
                          const Text(
                            'and ',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: indicator,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        user = FirebaseAuth.instance.currentUser;
      },
    ).whenComplete(
      () async {
        bool isUserExist = await getUser(user?.uid ?? '');
        if (!isUserExist && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUser(),
            ),
          );
          return;
        }
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  Future<bool> getUser(String userId) async {
    try {
      var getUserUrl = Uri.parse('${ApiService.url}/getUser.php');
      var reqBody = {"userId": userId};

      var response = await http.post(getUserUrl, body: reqBody);
      if (response.statusCode == 200) {
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
