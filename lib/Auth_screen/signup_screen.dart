import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   final formKey = GlobalKey<FormState>();
  var name = new TextEditingController();
  var email = new TextEditingController();
  var referral = new TextEditingController();
  var phoneController = new TextEditingController();
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
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: Icon(CupertinoIcons.clear),
                  ),
                )),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
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
                                  border:
                                      Border.all(width: 2, color: Colors.white),
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
                                  validator: (value){
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
                          controller: phoneController,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Phone Number',
                              prefix: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Text('+91'),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                           validator: (value){
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
                                   validator: (value){
                                    if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              } else if (!value.contains('@')) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                                  },
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Referral Code",
                          style: subtitle,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: referral,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Referral Code',
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        Visibility(
                          visible: otpVisibility,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              const Text('* Enter OTP', style: subtitle),
                              const SizedBox(height: 10),
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
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                 validator: (value){
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
                          height: 30,
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
                              addUser( );
                            }
                          },
                          child: Text(
                            otpVisibility ? "Verify" : "Sign Up",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 20,),
                         Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("If you have account? please",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));}, child: const Text('Sign In',style: TextStyle(
                                    fontSize: 14,
                                    color: indicator,
                                    fontWeight: FontWeight.bold),))
                        ],
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
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
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
              builder: (context) => HomePage(),
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

  Future<dynamic> addUser() async {
    try {
       String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final response = await http.post(
        Uri.parse('https://ezys.in/customerApp/addUser.php'),
        body: {
          'userId':userId,
          'name': name.text,
          'email': email.text,
          'phone': phoneController.text,
          'referral': referral.text,
        },
      );

      if (response.statusCode == 200) {
        print('User added successfully');
      } else {
        print('Failed to add user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
