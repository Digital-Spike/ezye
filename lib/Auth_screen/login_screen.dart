import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/homescreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          builder: (context) => HomePage(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Image.asset('assets/animation.gif'),
                SizedBox(height: 40),
                Text('* Log in using Mobile Number',style: title),
                SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Phone Number',
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text('+91'),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('* Enter OTP',style: title),
                      SizedBox(height: 20),
                      TextField(
                        controller: otpController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'OTP',
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(''),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  visible: otpVisibility,
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(elevation: 5,minimumSize: Size(double.infinity, 45),backgroundColor: buttonColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                 
                  onPressed: () {
                    if (otpVisibility) {
                      verifyOTP();
                    } else {
                      loginWithPhone();
                    }
                  },
                  child: Text(
                    otpVisibility ? "Verify" : "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text( "By continuing, you agree to Ezye's ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),),GestureDetector(
                      onTap: () {
                        
                      },
                      child: Text('Terms of Use ',style: TextStyle(fontSize: 12,color: indicator,fontWeight: FontWeight.bold),)),
                      Text('and ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Text('Privacy Policy',style: TextStyle(fontSize: 12,color: indicator,fontWeight: FontWeight.bold),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
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
}