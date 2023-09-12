import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor),
        title: Text('Track Order',style: apptitle,),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
            primary: true,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: DecorationImage(image: AssetImage('assets/image1.jpeg'),fit: BoxFit.cover,)),
                        
                      ),SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                  Text('Tiger Image EZYE',style: subtitle),
                                  SizedBox(height: 5),
                        Text('T-shirt',style: content,),
                        SizedBox(height: 5),
                        Text('Size: XL',style: content,),
                         SizedBox(height: 15),
                       Text(
                         'Price: ₹399',
                         style: TextStyle(fontWeight: FontWeight.bold),
                       )
                  
                                  
                        ],
                  )
                    ],
                  ),
                 
                ],
              ),
            );
          }),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text('Order Details',style: title,),
                 SizedBox(
                  height: 10,
                 ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Expected Delivery Date',style: content1,),
                        Text('03/11/2023',style: title,)
                      ],
                     ),
                      SizedBox(
                  height: 10,
                 ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tracking ID',style: content1,),
                        Text('TRK345678956',style: title,)
                      ],
                     ),
                      SizedBox(
                  height: 10,
                 ),
                     Divider(thickness: 1,color: Colors.grey[500],),
                     SizedBox(height: 20),
                     Text('Order Status',style: title,),
                     SizedBox(height: 15),
                    Container(
                      height: MediaQuery.of(context).size.height/2.5,
                      width: MediaQuery.of(context).size.width/6,
                      child: IconStepper(
                        scrollingDisabled: true,
                        activeStepBorderColor: Colors.white,
                        steppingEnabled: true,
                        activeStepColor: buttonColor,
                        enableNextPreviousButtons: false,
                        stepColor: Colors.grey[400],
                        direction: Axis.vertical,
                        activeStepBorderWidth: 0,
                        lineColor: buttonColor,
                        lineDotRadius: 1,
                        activeStepBorderPadding: 0,
                        stepRadius: 18,
                        icons: [
                          Icon(Icons.check,color: Colors.white,),
                          Icon(Icons.check,color: Colors.white,),
                           Icon(Icons.check,color: Colors.white,),
                          Icon(Icons.check,color: Colors.white,)
                        ],
                      ),
                    )
                
              
                    ],
                  ),
            ),]));
  }
   
}