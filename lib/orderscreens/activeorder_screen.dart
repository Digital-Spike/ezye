import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/orderscreens/trackorder_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ActiveOrder extends StatefulWidget {
  const ActiveOrder({super.key});

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: 2,
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),image: DecorationImage(image: AssetImage('assets/image1.jpeg'),fit: BoxFit.cover,)),
                              
                            ),SizedBox(width: 20),
                        Expanded(
                          child:  Column(
                            mainAxisSize: MainAxisSize.max,
                           mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                          Text('Tiger Image EZYE',style: subtitle),
                                          SizedBox(height: 5),
                                Text('T-shirt',style: content,),
                                SizedBox(height: 5),
                                Text('Size: XL',style: content,),
                                 SizedBox(height: 15),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price: ₹399',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                           ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackOrder()));
                            },
                             child: Text('Track Order',style: TextStyle(fontWeight: FontWeight.bold),))
                          ],
                        )
                        
                                          
                                ],
                          ),
                        )
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}