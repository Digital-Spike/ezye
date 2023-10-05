import 'package:ezys/custom_widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class MyAddress extends StatefulWidget {
  const MyAddress({Key? key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {

  String? type;

  var _name = new TextEditingController();
  var _house = new TextEditingController();
  var _street = new TextEditingController();
  var _city = new TextEditingController();
  var _pincode = new TextEditingController();
  var _state = new TextEditingController();
  var _email = new TextEditingController();
  var _mobile = new TextEditingController();
  var _mobile1 = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
 void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_name.text.isEmpty &&
         
          _mobile.text.isEmpty &&
          _email.text.isEmpty &&
          _house.text.isEmpty &&
          _street.text.isEmpty &&
          _city.text.isEmpty && 
          _mobile1.text.isEmpty &&
          _pincode.text.isEmpty &&
          _state.text.isEmpty&&
          type!.isEmpty
        ) {
        // No data added, return without saving
        return;
      }
    

      // Call API to save user data
      addUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        title: const Text('Shipping Address', style: apptitle),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(380, 50)),
                onPressed: () {},
                child: const Text('Save',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Home',
                   
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  const Text('Home'),
                  Radio<String>(
                    value: 'Work',
                  
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  const Text('Work'),
                  Radio<String>(
                    value: 'Others',
                  
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  const Text('Others'),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  hintText: 'Enter Full Name',

                  // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _house,
                decoration: const InputDecoration(
                  hintText: 'House/Flat/Door No',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _street,
                decoration: const InputDecoration(
                  hintText: 'Landmark/Street/Nearby',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _city,
                decoration: const InputDecoration(
                  hintText: 'Enter Your City',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _pincode,
                decoration: const InputDecoration(
                  hintText: 'Enter Pincode',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _state,
                decoration: const InputDecoration(
                  hintText: 'Enter Your State',
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Email',
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _mobile,
                 maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                ),
              ),
              TextFormField(
                controller: _mobile1,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Alternate Phone',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> addUser() async {
    try {
       String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      final response = await http.post(
        Uri.parse('https://ezys.in/customerApp/addAddress.php'),
        body: {
          'userId':userId,
          'name': _name.text,
          'house':_house.text,
          'street':_street.text,
          'city':_city.text,
          'pincode':_pincode.text,
          'state':_state.text,
          'type': type,
          'email': _email.text,
          'phone': _mobile.text,
          'phone1': _mobile1.text,
        },
      );

      if (response.statusCode == 200) {
        print('Address added successfully');
      } else {
        print('Failed to add Address. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
}
}