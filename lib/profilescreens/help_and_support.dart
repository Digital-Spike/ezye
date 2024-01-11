import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http; 

class HelpAndSupport extends StatefulWidget
 {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> 
{
 TextEditingController name=TextEditingController();
  TextEditingController mobile=TextEditingController();
 TextEditingController email=TextEditingController();
 TextEditingController message=TextEditingController();
   final _formKey = GlobalKey<FormState>();


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
  Widget build(BuildContext context)
   {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Help and Support',
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
      body: !isLoggedIn
          ? Padding(
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
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: Color(0xff7C7D85)),
                            hintText: 'Enter your name',
                            isDense: true,
                             border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    ),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                                    errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE)
                                    )
                                    ),
                                    ),
                                    validator: (value) 
                                    {
                                      if(value==null||value.isEmpty)
                                      {
                                        return 'please enter the name';
                                      }
                                      return null;
                                    },
                                    
                                    
                      ),
                     
                      const SizedBox(height: 20),
                      const Text(
                        'Mobile Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: mobile,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: Color(0xff7C7D85)),
                            hintText: 'Enter your mobile number',
                            isDense: true,
                             border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    ),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                                    errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    ),
                                    ),
                                       validator: (value) 
                                    {
                                      if(value==null||value.isEmpty)
                                      {
                                        return 'please enter the mobile number';
                                      }
                                      return null;
                                    },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: Color(0xff7C7D85)),
                            hintText: 'Enter your email address',
                            isDense: true,
                             border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                                    errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    ),                              
                                    ),
                                       validator: (value) 
                                    {
                                      if(value==null||value.isEmpty)
                                      {
                                        return 'please enter the address';
                                      }
                                      return null;
                                    },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Message',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700), 
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: message,
                        maxLength: 1000,
                        maxLines: 5,
                        decoration: InputDecoration(  
                            hintStyle:
                                const TextStyle(color: Color(0xff7C7D85)),
                            hintText: 'Write your query here',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)
                                    ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 1.5, color: Color(0xffE8E9EE))
                                    )
                                    ),
                                       validator: (value) 
                                    {
                                      if(value==null||value.isEmpty)
                                      {
                                        return 'please enter the message';
                                      }
                                      return null;
                                    },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(double.infinity, 56)),
                          onPressed: () 
                          {
                              if(_formKey.currentState!.validate()) 
                              {
                                
                              Navigator.pop(context);
// 
                               
                              } else{

             helpAndSupport();
             

                              }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                          ),
                      const SizedBox(height: 10)
                    ],
                  ),
                  ),
                  
                ),
              ),
            ),
    );
    
  
        
        }
        
        
                Future<bool> helpAndSupport() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.url}helpSupport.php'),
        body: {
          'mobile': mobile.text,
          'email': email.text,
          'message': message.text,
          'userId': FirebaseUser.user?.uid,

        }
      );
      
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  }

