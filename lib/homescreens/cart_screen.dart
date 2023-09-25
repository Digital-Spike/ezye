import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/paymentScreens/checkout_screen.dart';
import 'package:ezys/paymentScreens/coupan_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  final String image;
  final String title;
  final String size;
  final String price;
  int counter; // Make it non-final

  CartScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.size,
    required this.price,
    required this.counter, // Remove final here
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoggedIn = false;
int counter = 0;
 List<Widget> cartItems = []; // List to store cart items
  ScrollController _scrollController = ScrollController();
  bool showOriginalContainer = false;
   void incrementCounter() {
  setState(() {
    widget.counter++;
  });
}

void decrementCounter() {
  setState(() {
    if (widget.counter > 0) {
      widget.counter--;
    }
  });
}


  void moveToTop(int index) {
    // Scroll the ListView to the top when an item is saved for later
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
@override
void initState() {
  super.initState();
  checkLoginStatus(); 
}

void checkLoginStatus() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    setState(() {
      isLoggedIn = true;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('My Cart',style: apptitle),
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            
            Expanded(
              child: ListView.builder(
                
                itemCount: 1,
                itemBuilder: (context, index) {
                return Slidable(
                  
                   endActionPane: ActionPane(motion: const BehindMotion(), children: [SlidableAction(onPressed: ((context){}),icon: CupertinoIcons.delete,backgroundColor: Colors.red.shade300,label: 'Remove')]),
                  
                  child: Container(
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: DecorationImage(image: AssetImage(widget.image),fit: BoxFit.contain,)),
                              
                            ),SizedBox(width: 20),
                        Expanded(
                          child:  Column(
                            mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                          Text(widget.title,style: subtitle),
                                          SizedBox(height: 5),
                                Text('T-shirt',style: content,),
                                SizedBox(height: 5),
                                Text('Size + ${widget.size}',style: content,),
                                 SizedBox(height: 15),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.price,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                             
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(width: 0.5, color: Colors.grey.shade200),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      decrementCounter();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey[300],
                                      ),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${widget.counter}',
                                    // '$counter',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      incrementCounter();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: buttonColor,
                                      ),
                                      child: Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        
                                          
                                ],
                          ),
                        )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('View Similar Products',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 0.5,color: Colors.grey.shade400)),child: Text('Save For Later',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15),
               child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),minimumSize: Size(380, 50)),
                onPressed: (){
                  showModalBottomSheet(
                    showDragHandle: true,
                    backgroundColor: bgcolor,
                              elevation: 5,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height: 350,
                                  color: bgcolor,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                            //   child: SizedBox(
                                            //     height: 45,
                                            //     child: TextField(
                                            //       decoration: InputDecoration(
                                            //         isDense: true,
                                            //         hintText: 'Promo Code',
                                            //         suffixIcon: Padding(
                                            //           padding: const EdgeInsets.all(3.0),
                                            //           child: ElevatedButton(
                                            //             style: ElevatedButton.styleFrom(
                                            //               backgroundColor: buttonColor,
                                            //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),minimumSize: Size(80, 40)),
                                            //             onPressed: (){}, child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold),)),
                                            //         ),
                                            //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(
                                              height: 90,
                                            decoration: BoxDecoration(border: Border.all(width: 0.5,color: Colors.grey.shade600),borderRadius: BorderRadius.circular(12)),
                                              child: Column(
                                                children: [
                                                  Container(padding: EdgeInsets.only(
                                                    top: 15,left: 20,right: 20,bottom: 10
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('WELCOME100',style: title,), GestureDetector(
                                                        onTap: () {
                                                          
                                                        },
                                                        child: Text('Apply',style: title1,))
                                                    ],
                                                  ),
                                                  ),
                                                  Divider(thickness: 0.5,color: Colors.grey[500],),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CoupanPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("View more Coupon's",style: content2,),Icon(CupertinoIcons.forward,color: Colors.grey[600],)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Sub-Total',style: TextStyle(fontSize: 16,color: Colors.grey[600]),),Text('₹399',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],),
                                            SizedBox(height: 15),

                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Delivery Fee',style: TextStyle(fontSize: 16,color: Colors.grey[600]),),Text('₹49',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],),
                                               SizedBox(height: 15),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Discount',style: TextStyle(fontSize: 16,color: Colors.grey[600]),),Text('- ₹59',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],),
                                                 SizedBox(height: 10),
                                                 Divider(thickness: 0.5,color: Colors.grey[500],),
                                                  SizedBox(height: 10),
                                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('Total',style: TextStyle(fontSize: 16,color: Colors.grey[600]),),Text('₹389',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],),
                                            

                                           SizedBox(height: 20),
                                      ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                          minimumSize: const Size(400, 50),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      onPressed: () {
                                         if (isLoggedIn) {
              // User is logged in, navigate to the payment page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckOutPage()));
            } else {
              // User is not logged in, show the login dialog
              _showLoginDialog();
            }
                                     
                                      },
                                      child: const Text(
                                        'Proceed to Checkout',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          
                    
                  
                },
                 child: Text('Checkout',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
             ),
             SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
   void _showLoginDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Login Required!',style: TextStyle(color: indicator)),
          content: Text('You need to log in to continue with the Checkout.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.w700),),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              child: Text('Log In',style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }
}