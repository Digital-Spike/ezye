import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/home_screens/home_screen.dart';
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
  bool isLoggedIn = false;
  String? canCall;
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
        leading: const BackButton(color: Colors.black),
        title: const Text('Checkout', style: apptitle),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                const Text('₹399',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(150, 45)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()));
              },
              child: const Row(
                children: [
                  Text(
                    'Continue to Payment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Shipping Address', style: title),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(CupertinoIcons.placemark),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Home', style: subtitle),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        '64/1 B Vinaya marga, Siddhartha layout, Mysore Pincode 570011 ',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.5),
                      )),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            _address();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAddress()));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 0.5, color: Colors.grey.shade400)),
                            child: const Text(
                              'CHANGE',
                              style: TextStyle(color: Colors.green),
                            ),
                          ))
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[500],
                ),
                const SizedBox(height: 10),
                const Text('Choose Shipping Type', style: title),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(CupertinoIcons.cube_box_fill),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Economy', style: subtitle),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        'Estimated Arrival 18 september 2023 ',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14.5),
                      )),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 0.5, color: Colors.grey.shade400)),
                        child: const Text(
                          'CHANGE',
                          style: TextStyle(color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Order List', style: title),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        onPressed: ((context) {}),
                        icon: CupertinoIcons.delete,
                        backgroundColor: Colors.red.shade300,
                        label: 'Remove',
                      )
                    ]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/image1.jpeg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('Tiger Image EZYE', style: subtitle),
                                const SizedBox(height: 5),
                                Text('T-shirt', style: content),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text('Size: XL', style: content),
                                    const SizedBox(width: 5),
                                    Container(
                                      height: 12,
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Qty : 2',
                                      style: content,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price: ₹399',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
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
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.25, color: Colors.grey.shade400),
                  color: Colors.white),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add More Items',
                    style: subtitle,
                  ),
                  Icon(CupertinoIcons.add_circled)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _address() {
    showModalBottomSheet(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 350,
                padding: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'Shipping Address',
                          style: title,
                        ),
                      ),
                      const SizedBox(height: 5),
                      devider,
                      SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Radio<String>(
                                      value: 'Home',
                                      // Use 'NO' as the value for the "NO" option

                                      groupValue: canCall,
                                      onChanged: (value) {
                                        setState(() {
                                          canCall = value!;
                                        });
                                      },
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              CupertinoIcons.placemark,
                                              color: buttonColor,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Home',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            '64/1 B Vinaya marga, Siddhartha layout, Mysore Pincode 570011',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Divider(
                                        thickness: 0.5,
                                        color: Colors.grey[400]),
                                  )
                                ],
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyAddress()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add New Shipping Address',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
