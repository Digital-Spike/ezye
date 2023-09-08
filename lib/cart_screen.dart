import 'package:ezys/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('My Cart',style: TextStyle(color: Colors.black),),
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
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
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 15),
               child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),minimumSize: Size(380, 50)),
                onPressed: (){
                  showModalBottomSheet(
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
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                              child: SizedBox(
                                                height: 45,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: 'Promo Code',
                                                    suffixIcon: Padding(
                                                      padding: const EdgeInsets.all(3.0),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),minimumSize: Size(80, 40)),
                                                        onPressed: (){}, child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold),)),
                                                    ),
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                                                ),
                                              ),
                                            ),SizedBox(height: 15),
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
                                          minimumSize: const Size(400, 50),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      onPressed: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage()));
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
                 child: Text('View Price Break Up',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
             ),
             SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}