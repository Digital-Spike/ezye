
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/orderscreens/myaddress_screen.dart';
import 'package:ezys/paymentScreens/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
//   int counter = 0;
//   bool showOriginalContainer = false;
//     void incrementCounter() {
//     setState(() {
//       counter++;
//     });
//   }

//   void decrementCounter() {
//     setState(() {
//       if (counter > 0) {
//         counter--;
//       }
//     });
//   }
//    void toggleContainer() {
//   setState(() {
//     showOriginalContainer = !showOriginalContainer;
//     if (showOriginalContainer) {
//       if (counter == 0) {
//         counter = 1; // Set counter to 1 when showing the original container
//       }
//     } else {
//       if (counter == 1) {
//         counter = 0; // Set counter to 0 when showing the "Add" text
//       }
//     }
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text('Checkout',style: apptitle),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping Address',style: title),
                SizedBox(
                  height: 10
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.placemark),SizedBox(width: 5,),Text('Home',style: subtitle),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('64/1 B Vinaya marga, Siddhartha layout, Mysore Pincode 570011 ',style: TextStyle(color: Colors.grey[600],fontSize: 14.5),)),SizedBox(width: 40,),GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAddress()));
                        },child: Container(margin: EdgeInsets.all(5),padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('CHANGE',style: TextStyle(color: Colors.green),),))
                    ],
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey[500],),
                SizedBox(height: 10),
                 Text('Choose Shipping Type',style: title),
                SizedBox(
                  height: 10
                ),
                 Row(
                  children: [
                    Icon(CupertinoIcons.cube_box_fill),SizedBox(width: 5,),Text('Economy',style: subtitle),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('Estimated Arrival 18 september 2023 ',style: TextStyle(color: Colors.grey[600],fontSize: 14.5),)),SizedBox(width: 40,),Container(margin: EdgeInsets.all(5),padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('CHANGE',style: TextStyle(color: Colors.green),),)
                    ],
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey[500],),
               
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            
            child: Text('Order List',style: title),
          ),
          SizedBox(height: 5),
           Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                    return Slidable(
                       endActionPane: ActionPane(motion: const BehindMotion(), children: [SlidableAction(onPressed: ((context){}),icon: CupertinoIcons.delete,backgroundColor: Colors.red.shade300,label: 'Remove',)]),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
                        child: Row(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: DecorationImage(image: AssetImage('assets/image1.jpeg'),fit: BoxFit.cover,)),
                              
                            ),SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                              Text('Tiger Image EZYE',style: subtitle),
                                              SizedBox(height: 5),
                                Text('T-shirt',style: content),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('Size: XL',style: content),SizedBox(width: 5),Container(height: 12,width: 1,color: Colors.black,),SizedBox(width: 5),Text('Qty : 2',style: content,)
                                  ],
                                ),
                                 SizedBox(height: 15),
                              const  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              
                                              children: [
                          Text('Price: ₹399',style: TextStyle(fontWeight: FontWeight.bold),),
                          // Container(
                          //                         height: 35,
                          //                         width: 100,
                          //                         decoration: BoxDecoration(
                          //                           borderRadius: BorderRadius.circular(7),
                          //                           border: Border.all(width: 0.5,color: Colors.grey.shade200)
                          //                         ),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment.spaceBetween,
                          //                           children: [
                          //                             GestureDetector(
                          //                               onTap: () {
                          //                                 decrementCounter();
                          //                               },
                          //                               child: Container(
                          //                                 padding: EdgeInsets.all(4),
                          //                                 decoration: BoxDecoration(
                          //                                     borderRadius:
                          //                                         BorderRadius.circular(5),
                          //                                     color: Colors.grey[300]),
                          //                                 child: Icon(
                          //                                   CupertinoIcons.minus,
                          //                                   color: Colors.black,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             SizedBox(width: 5),
                          //                             Text(
                          //                               '$counter',
                          //                               style: TextStyle(
                          //                                   fontWeight: FontWeight.bold,
                          //                                   color: Colors.black),
                          //                             ),
                          //                             SizedBox(width: 5),
                          //                             GestureDetector(
                          //                               onTap: () {
                          //                                 incrementCounter();
                          //                               },
                          //                               child: Container(
                          //                                 padding: EdgeInsets.all(4),
                          //                                 decoration: BoxDecoration(
                          //                                     borderRadius:
                          //                                         BorderRadius.circular(5),
                          //                                     color: Colors.brown[300]),
                          //                                 child: Icon(
                          //                                   CupertinoIcons.add,
                          //                                   color: Colors.black,
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                                               
                                              ],
                                )
                                          
                                ],
                          ),
                        )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  height: 100,color: Colors.white,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text('₹399',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: Size(150, 45)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
                  },
                  child: Row(
                   
                    children: [
                     
                      Text(
                        'Continue to Payment',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ))],),)
        ],
      ),
    );
  }
}