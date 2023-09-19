import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  int? _selectedValue; // Store the selected radio button value
  String? canCall;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        elevation: 0,
        title: Text('Shipping Address', style: apptitle),
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
                    minimumSize: Size(380, 50)),
                onPressed: () {},
                child: const Text('Apply',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
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
                    // Use 'YES' as the value for the "YES" option
                    groupValue: canCall,
                    onChanged: (value) {
                      setState(() {
                        canCall = value!;
                      });
                    },
                  ),
                  Text('Home'),
                  Radio<String>(
                    value: 'Work',
                    // Use 'NO' as the value for the "NO" option
                    groupValue: canCall,
                    onChanged: (value) {
                      setState(() {
                        canCall = value!;
                      });
                    },
                  ),
                  Text('Work'),
                  Radio<String>(
                    value: 'Others',
                    // Use 'NO' as the value for the "NO" option
                    groupValue: canCall,
                    onChanged: (value) {
                      setState(() {
                        canCall = value!;
                      });
                    },
                  ),
                  Text('Others'),
                ],
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Full Name',

                  // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'House/Flat/Door No',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Landmark/Street/Nearby',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Your City',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Pincode',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Your State',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                ),
              ),
              SizedBox(height: 14),
              TextField(
                 maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                ),
              ),
             
              TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Alternate Phone',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
