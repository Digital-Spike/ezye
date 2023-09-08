import 'package:ezys/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int counter = 0;
  bool showOriginalContainer = false;
    void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }
   void toggleContainer() {
  setState(() {
    showOriginalContainer = !showOriginalContainer;
    if (showOriginalContainer) {
      if (counter == 0) {
        counter = 1; // Set counter to 1 when showing the original container
      }
    } else {
      if (counter == 1) {
        counter = 0; // Set counter to 0 when showing the "Add" text
      }
    }
  });
}
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
      body: Column(
        children: [
          Padding(
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
                    Icon(CupertinoIcons.location),SizedBox(width: 5,),Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('64/1 B Vinaya marga, Siddhartha layout, Mysore Pincode 570011 ',style: TextStyle(color: Colors.grey[600],fontSize: 14.5),textAlign: TextAlign.justify,)),SizedBox(width: 40,),Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('CHANGE',style: TextStyle(color: Colors.green),),)
                    ],
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey[500],),
                SizedBox(height: 10),
                 Text('Choose Shipping Type',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10
                ),
                 Row(
                  children: [
                    Icon(CupertinoIcons.cube_box_fill),SizedBox(width: 5,),Text('Economy',style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('Estimated Arrival 18 september 2023 ',style: TextStyle(color: Colors.grey[600],fontSize: 14.5),textAlign: TextAlign.justify,)),SizedBox(width: 40,),Container(padding: EdgeInsets.all(5),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('CHANGE',style: TextStyle(color: Colors.green),),)
                    ],
                  ),
                ),
                Divider(thickness: 0.5,color: Colors.grey[500],),
               
                
              ],
            ),
          ),
           Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                    return Slidable(
                       endActionPane: ActionPane(motion: const BehindMotion(), children: [SlidableAction(onPressed: ((context){}),icon: Icons.delete,backgroundColor: Colors.red,)]),
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
                        Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                      Text('Tiger Image EZYE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 5),
                              Text('T-shirt',style: TextStyle(color: Colors.grey[600]),),
                              SizedBox(height: 5),
                              Text('Size: XL',style: TextStyle(color: Colors.grey[600]),),
                               SizedBox(height: 15),
                              Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Text('Price: ₹399',style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 60),
                        Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(7),
                                                  border: Border.all(width: 0.5,color: Colors.grey.shade200)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        decrementCounter();
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(4),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(5),
                                                            color: Colors.grey[300]),
                                                        child: Icon(
                                                          CupertinoIcons.minus,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      '$counter',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(width: 5),
                                                    GestureDetector(
                                                      onTap: () {
                                                        incrementCounter();
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(4),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(5),
                                                            color: Colors.brown[300]),
                                                        child: Icon(
                                                          CupertinoIcons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                             
                      ],
                              )
                                        
                              ],
                        )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(20),
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