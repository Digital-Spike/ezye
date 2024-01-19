// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/user.dart';
import 'package:ezye/orderscreens/confirmation_screen.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
  var referral = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String baseimage = "";
  ImagePicker picker = ImagePicker();
  XFile? uploadimage;
  String imageUrl = "";
  void getUser() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = "https://ezys.in/customerApp/getUser.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      "userId": userId,
    });
    var jsondata =
        json.decode((response.body).toString().replaceAll('connected', ''));
    print(jsondata);
    setState(() {
      // name = jsondata[0]['name'];
      // phone = jsondata[0]['mobile'];
      imageUrl = 'https://ezys.in/customerApp/upload/$userId.php';
    });
  }

  @override
  void initState() {
    getUser();
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
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              showProcessingDialogue();
              _saveUserData();
            },
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
                  InkWell(
                    onTap: () async {
                      try {
                        var choosedimage =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          uploadimage = choosedimage;
                        });
                        List<int> imageBytes = await uploadimage!.readAsBytes();
                        // print(choosedimage);
                        String baseimage = base64Encode(imageBytes);
                        print(baseimage);
                        String employerId =
                            FirebaseAuth.instance.currentUser?.uid ?? '';
                        String apiUrl =
                            'https://ezys.in/customerApp/uploadImage.php';
                        var response = await http.post(Uri.parse(apiUrl),
                            body: {
                              'userId': employerId,
                              'imageUrl': baseimage
                            });

                        if (response.statusCode == 200) {
                          print(response.body);

                          setState(() {
                            imageUrl = response.body;
                            getUser();
                          });
                        } else {}
                      } catch (error) {
                        // Show a Snackbar for any unexpected errors
                      }
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              width: 1.5, color: const Color(0xffE8E9EE))),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person);
                        },
                      ),
                    ),
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
                      const SizedBox(height: 15),
                      const Text(
                        "Referral Code",
                        style: subtitle,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: referral,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter referral code',
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

  showProcessingDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Creating your account...',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _saveUserData() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    var reqBody = {
      'userId': userId,
      'name': name.text,
      'email': email.text,
      'mobile': FirebaseAuth.instance.currentUser?.phoneNumber,
      'cartId': FirebaseUser.getCartId()
    };

    var response = await http.post(
      Uri.parse('${ApiService.url}addUser.php'),
      body: reqBody,
    );

    if (response.statusCode == 200) {
      Provider.of<SessionObject>(context, listen: false).user =
          UserModel.fromJson(reqBody);
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            pageBuilder: (context, a, b) => const ConfirmationScreen(
                  title:
                      'Congratulations! Your\naccount has been successfully\ncreated.',
                  subtitle: '',
                  image: 'assets/png/registered.png',
                  svgpath: 'assets/svg/registered.svg',
                )),
        (route) => false,
      );
    }
  }
}
