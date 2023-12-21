import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/profilescreens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/materialet {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser;
  late String? _phone;
  var _name = new TextEditingController();
  var _mobile = new TextEditingController();
  var _email = new TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_name.text.isEmpty && _phone!.isEmpty && _email.text.isEmpty) {
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
      'mobile': _phone ?? '',
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
        print(
            'Response Body: ${(response.body).toString().replaceAll('connected', '')}');
      }
    }

    teststatus();
  }

  @override
  void initState() {
    getUser();
    _phone = user!.phoneNumber?.replaceFirst('+91', '');
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: buttonColor),
        title: const Text('Edit Your Profile', style: apptitle),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                    border:
                        Border.all(width: 1.5, color: const Color(0xffE8E9EE))),
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
                    controller: _name,
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
                  const SizedBox(height: 20),
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
                            color: const Color(0xffE8E9EE)),
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
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffE8E9EE),
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
                  const SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: subtitle,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
              const Spacer(),
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
                          _name.clear();
                          _email.clear();
                        },
                        child: const Text(
                          'Undo Changes',
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
                          _showDialog();
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

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
      _name.text = jsondata[0]['name'];
      _phone = jsondata[0]['mobile'];
      _email.text = jsondata[0]['email'];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            insetPadding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: const Center(
              child: Text(
                'Are you sure?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            content: const Text(
              'Saving changes will update your Profile. Confirm to proceed.',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff7C7D85)),
              textAlign: TextAlign.center,
            ),
            actionsPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                            minimumSize: const Size(154, 56)),
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
                            minimumSize: const Size(154, 56)),
                        onPressed: () {
                          _submitForm;
                          Navigator.pop(context);
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
