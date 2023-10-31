import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/profilescreens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _name = new TextEditingController();
  var _mobile = new TextEditingController();
  var _email = new TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_name.text.isEmpty && _mobile.text.isEmpty && _email.text.isEmpty) {
        return;
      }

      editUser();
    }
  }

  Future<dynamic> editUser() async {
    String userId = await FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = 'https://ezys.in/customerApp/editProfile.php';
    var response = await http.post(Uri.parse(apiUrl), body: {
      'userId': userId,
      'name': _name.text.toString(),
      'mobile': _mobile.text.toString(),
      'email': _email.text.toString()
    });
    void teststatus() async {
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
                pageBuilder: (context, a, b) => const ProfilePage()),
            (route) => false);
      } else {
        print('Failed to add job');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    }

    teststatus();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor),
        title: Text('Edit Your Profile', style: apptitle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                          border: Border.all(width: 2, color: Colors.white),
                          color: Colors.grey,
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        'assets/icons/Edit (1).svg',
                        height: 20,
                        width: 20,
                      )))
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: subtitle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Phone Number",
                    style: subtitle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _mobile,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Number',
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
                  SizedBox(height: 15),
                  Text(
                    "Email",
                    style: subtitle,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
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
                  SizedBox(height: 60),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        _submitForm;
                      },
                      child: Text('Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
