import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Select Address',
          style: apptitle,
        ),
        centerTitle: true,
        leading: const BackButton(color: buttonColor),
      ),
      body: const Center(child: Text("No notifications found.")),
    );
  }
}
