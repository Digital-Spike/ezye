import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CoupanPage extends StatefulWidget {
  const CoupanPage({super.key});

  @override
  State<CoupanPage> createState() => _CoupanPageState();
}

class _CoupanPageState extends State<CoupanPage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
          title: Text(
            "Coupon's",
            style: apptitle,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        mainChild:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Best offers for you',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              ),

              TicketWidget(
                  isCornerRounded: true,
                  width: double.infinity,
                  height: 180,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
