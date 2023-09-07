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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
          return Slidable(
             endActionPane: ActionPane(motion: const BehindMotion(), children: [SlidableAction(onPressed: ((context){}),icon: Icons.delete,backgroundColor: Colors.red,)]),
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: DecorationImage(image: AssetImage('assets/image1.jpeg'),fit: BoxFit.cover,)),
                    
                  ),SizedBox(width: 20),
              Column(
               mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            Text('Tiger Image EZYE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
            SizedBox(height: 5),
                    Text('T-shirt',style: TextStyle(color: Colors.grey),),
                     SizedBox(height: 35),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price: ₹399',style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 15),
              Container(
                                      height: 35,
                                      width: 110,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 1.5, color: Colors.green.shade400)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              decrementCounter();
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.green[400],
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '$counter',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[400]),
                                          ),
                                          SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              incrementCounter();
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.green[400],
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
    );
  }
}