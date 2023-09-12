import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/profile_button.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:ezys/orderscreens/myorder_screen.dart';
import 'package:ezys/profilescreens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(color: buttonColor),
          title: Text(
            'Profile',
            style: apptitle,
          ),
          centerTitle: true,
        ),
        mainChild: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Stack(
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
                        left: 210,
                        right: 130,
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                            child: Icon(Icons.edit)))
                  ],
                ),
              ),
              CustomButton(
                  title1: 'Edit Profile',
                  leadingIcon: Icons.edit,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {}),
              divider,
              CustomButton(
                  title1: 'Payment Methods',
                  leadingIcon: CupertinoIcons.creditcard,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {}),
              divider,
              CustomButton(
                  title1: 'My Orders',
                  leadingIcon: CupertinoIcons.cube_box,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderPage()));
                  }),
              divider,
              CustomButton(
                  title1: 'Settings',
                  leadingIcon: Icons.settings_outlined,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                  }),
              divider,
              CustomButton(
                  title1: 'Help Center',
                  leadingIcon: Icons.help_outline,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {}),
              divider,
              CustomButton(
                  title1: 'Privacy Policy',
                  leadingIcon: Icons.privacy_tip_outlined,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {}),
              divider,
              CustomButton(
                  title1: 'Invite Friends',
                  leadingIcon: CupertinoIcons.share,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {}),
              divider,
              CustomButton(
                  title1: 'Log out',
                  leadingIcon: Icons.logout_sharp,
                  trailingIcon: CupertinoIcons.forward,
                  onPressed: () {
                     showModalBottomSheet(
                              elevation: 5,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height: 200,
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                       Text('Logout',style: title,),
                                       SizedBox(height: 10),
                                       divider,
                                       SizedBox(height: 10),
                                       Text('Are you sure you want to log out?',style: content1,),
                                      SizedBox(height: 15),
                                      Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  style: OutlinedButton.styleFrom(elevation: 0,backgroundColor: Colors.grey[300],minimumSize: Size(double.infinity, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                                  onPressed: (){}, child: Text('Cancel',style: subtitle1,)),
                                              ),
                                              SizedBox(width: 10),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    
                                                  style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: buttonColor,minimumSize: Size(double.infinity, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                                  onPressed: (){}, child: Text('Yes, Logout',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
                                                )
                                            ],
                                          ),
                                                                 
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                  }
                  ),
            ],
          ),
        ));
  }
}
