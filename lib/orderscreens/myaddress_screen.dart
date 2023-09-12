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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        elevation: 0,
        title: Text('Shipping Address', style: apptitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: ((context, index) {
                        return Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Radio<int>(
                                  value:
                                      index, // Set the value of this radio button
                                  groupValue:
                                      _selectedValue, // Current selected value
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue =
                                          value; // Update the selected value
                                    });
                                  },
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(CupertinoIcons.placemark,color: buttonColor,),
                                        SizedBox(width: 5),
                                        Text(
                                          'Home',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        '64/1 B Vinaya marga, Siddhartha layout, Mysore Pincode 570011',
                                        style: TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                    thickness: 0.5, color: Colors.grey[400]),
                              )
                            ],
                          ),
                        );
                      })),
                ),
              Container(
  height: 60,
  width: double.infinity,
  
    
   
    
  ),
   DottedBorder(
    borderPadding: EdgeInsets.symmetric(horizontal: 15),

dashPattern: [5,3],
    strokeCap: StrokeCap.butt,
    strokeWidth: 1,
    radius: Radius.circular(20),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
       style: TextButton.styleFrom(
       padding: EdgeInsets.all(12),
       backgroundColor: Colors.grey[300]
       ),
        onPressed: (){}, child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.add,color: Color(0xffb22024),),SizedBox(width: 5),Text('Add New Shipping Address',style: subtitle1,)
        ],
      ),),
    ) ),


              ],
            ),
          ),
          
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
