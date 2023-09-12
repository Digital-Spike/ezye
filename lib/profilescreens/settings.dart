import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/profile_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Settings',style: apptitle,),
        centerTitle: true,
        leading: BackButton(color: buttonColor),
      ),
      body: Column(
       
        children: [
          CustomButton(title1: 'Notification Settings', leadingIcon: CupertinoIcons.person, trailingIcon: CupertinoIcons.forward, onPressed: (){}),
          SizedBox(height: 10),
            CustomButton(title1: 'Delete Account', leadingIcon: CupertinoIcons.creditcard, trailingIcon: CupertinoIcons.forward, onPressed: (){}),
        ],
      ),
    );
  }
}