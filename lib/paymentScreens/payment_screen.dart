import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        title: Text('Payment Method',style: apptitle,),
        centerTitle: true,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),minimumSize: Size(double.infinity, 50),backgroundColor: buttonColor),
            onPressed: (){}, child: Text('Confirm Payment' ,style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Options',style: title,),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white,),
              
                child:   RadioMenuButton(  
        
                    value: 1,
                   groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                       _value= value!;
                       
                      });
                    },
                    trailingIcon:  Image.asset('assets/phonepe copy.png',height: 60,width: 100,),
                     child: Text(''),
              ))
            ],
          ),
        ),
      ),
    );
  }
}