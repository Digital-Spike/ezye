import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/snackbar.dart';
import 'package:ezys/custom_widgets/status.dart';
import 'package:ezys/custom_widgets/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
 void copyToClipboard(String textToCopy) {
  Clipboard.setData(ClipboardData(text: textToCopy));
}


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: buttonColor),
        title: const Text('Track Order',style: apptitle,),
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
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 2),
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: const DecorationImage(image: AssetImage('assets/image1.jpeg'),fit: BoxFit.cover,)),
                        
                      ),const SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                  const Text('Tiger Image EZYE',style: subtitle),
                                  const SizedBox(height: 5),
                        Text('T-shirt',style: content,),
                        const SizedBox(height: 5),
                        Text('Size: XL',style: content,),
                         const SizedBox(height: 15),
                       const Text(
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
            const Text('Order Details',style: title,),
                 const SizedBox(
                  height: 10,
                 ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Expected Delivery Date',style: content1,),
                        const Text('03/11/2023',style: title,)
                      ],
                     ),
                      const SizedBox(
                  height: 10,
                 ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tracking ID',style: content1,),
                        GestureDetector(
                          onTap: () async {
  await Clipboard.setData(const ClipboardData(text: "TRK345678956",));
  ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    width: double.infinity,
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
    content: CustomSnack(snackcontent: 'ID copied to clipboard.', imagePath: 'assets/Snack Bar 4.png',)
  ),
);

  // copied successfully
},
                          child: const Row(children: [Text('TRK345678956',style: title,),SizedBox(width: 5,),Icon(Icons.copy)]))
                      ],
                     ),
                      const SizedBox(
                  height: 10,
                 ),
                     Divider(thickness: 1,color: Colors.grey[500],),
                     const SizedBox(height: 20),
                     const Text('Order Status',style: title,),
                     
                    const MyTimeLine(isFirst: true, isLast: false, isPast: true, status: Status(heading: 'Order Placed', subtitle: '23/04/2023, 04:45 PM', svgpath: 'assets/icons/Order Placed.svg',) ),
                    const MyTimeLine(isFirst: false, isLast: false, isPast: true, status: Status(heading: 'In Progress', subtitle: '23/04/2023, 08:50 PM', svgpath: 'assets/icons/In transit.svg',) ),
                    const MyTimeLine(isFirst: false, isLast: false, isPast: false, status: Status(heading: 'Shipped', subtitle: 'Expected 25/04/2023', svgpath: 'assets/icons/Order.svg',) ),
                    const MyTimeLine(isFirst: false, isLast: true, isPast: false, status: Status(heading: 'Delivered', subtitle: 'Expected 26/04/2023', svgpath: 'assets/icons/delivered.svg',) ),
                  
                  
               
              
                    ],
                  ),
            ),]));
  }
   
}