import 'dart:convert';

import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/homescreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
var name = new TextEditingController();
var email = new TextEditingController();
var phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor),
        title: Text('Create Profile',style: apptitle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 40),
          Center(child: Text('Create Your Profile',style: title,)),
          SizedBox(height: 40),
          Stack(
                  children: [
                    Center(
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
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset('assets/icons/Edit (1).svg',height: 20,width: 20,)))
                  ],
                ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",style: subtitle,),
          SizedBox(height: 10),
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: 'Enter Your Name',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),
          ),
           SizedBox(height: 15),
           Text("Phone Number",style: subtitle,),
          SizedBox(height: 10),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter Your Number',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),
          ),
           SizedBox(height: 15),
           Text("Email",style: subtitle,),
          SizedBox(height: 10),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50),backgroundColor: buttonColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            onPressed: (){}, child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)))
        ],
        ),
      )
        ],
      ),
    );
  }
   Future<dynamic> _saveUserData() async {
    

    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = "https://ezys.in/customerApp/addUser.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      "userId": userId,
     "name":name.text,
     "email":email.text,
     "phone":phone.text,
    });
    void teststatus() async {
      var jsondata = json.decode(response.body);
      
     
      if (response.statusCode == 200) {
       
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (context, a, b) => HomePage()),
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
    teststatus();
  }
}