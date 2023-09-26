import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/orderscreens/activeorder_screen.dart';
import 'package:ezys/orderscreens/cancelledorder_screen.dart';
import 'package:ezys/orderscreens/completedorder_screen.dart';
import 'package:flutter/material.dart';
class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor),
        title: Text('My Orders',style: apptitle,),
        centerTitle: true,
      ),
body:  DefaultTabController(
                          length: 3, // Number of tabs
                          child: Column(children: [
                            Container(
                              color: Colors.white,
                              child: TabBar(
                              indicatorColor: indicator,
                              
                                indicatorWeight: 4,
                               indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                tabs: [
                                  Tab(text: 'Active'), // First tab
                                  Tab(text: 'Completed'), 
                                  Tab(text: 'Cancelled',)// Second tab
                                ],
                              ),
                            ),
                            Expanded(
                              
                              child: const TabBarView(
                                children: [
                                 ActiveOrder(),CompletedOrder(),CancelledOrder()
                                ],
                              ),
                            )
                          ])),
    );
  }
}