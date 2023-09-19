import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/snackbar.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_widget/ticket_widget.dart';

class CoupanPage extends StatefulWidget {
  const CoupanPage({super.key});

  @override
  State<CoupanPage> createState() => _CoupanPageState();
}

class _CoupanPageState extends State<CoupanPage> {
   void copyToClipboard(String textToCopy) {
  Clipboard.setData(ClipboardData(text: textToCopy));
}

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
                child: Text('Best offers for you',style: title),
              ),

             Expanded(
               child: ListView.builder(
                primary: true,
                shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                              return  TicketWidget(
                                margin: EdgeInsets.symmetric(vertical: 10),
                    isCornerRounded: true,
                    width: double.infinity,
                    height: 180,
                    child: Container(
                    
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 40,top: 20,bottom: 10),
                           child: Text('WELCOME200',style: title,),
                         ),
                          Padding(
                           padding: const EdgeInsets.only(left: 40,bottom: 10),
                           child: Text("Add items worth ₹1000 more to unlock ",style: content,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 40,bottom: 10),
                           child: Row(
                             children: [
                              Image.asset('assets/icons/discount.png',height: 30,width: 30,color: buttonColor,),
                              SizedBox(width: 5),
                               Text("Get 50% OFF",style: title,),
                             ],
                           ),
                         ),
                         GestureDetector(
                          onTap: () async {
               await Clipboard.setData(ClipboardData(text: "WELCOME200",));
               ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                 duration: Duration(seconds: 1),
                 content: CustomSnack(snackcontent: 'Code Applied Successfully', imagePath: 'assets/Snack Bar 6.png', )
               ),
               );
               
               // copied successfully
               },
                           child: Container(
                            
                            height: 40,
                            width: double.infinity,
                           
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)), color: Colors.grey[400],),
                            child: Center(child: Text('APPLY CODE',style: title,)),
                           ),
                         )
                        ],
                      ),
                    ));
               }),
             )],
          ),
        ));
  }
}
