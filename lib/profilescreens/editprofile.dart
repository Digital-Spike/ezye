import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor),
        title: Text('Edit Your Profile',style: apptitle),
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
}