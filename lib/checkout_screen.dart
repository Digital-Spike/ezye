import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text('Checkout',style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Address',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10
            ),
            Row(
              children: [
                Icon(CupertinoIcons.location),SizedBox(width: 5,),Text('Home',style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            )
          ],
        ),
      ),
    );
  }
}