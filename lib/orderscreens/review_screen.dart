import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: buttonColor,),
        title: Text('Leave Review',style: apptitle,),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.5,color: Colors.grey.shade400))),
       width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: Colors.grey[300],minimumSize: Size(double.infinity, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: (){}, child: Text('Cancel',style: subtitle1,)),
            ),
            SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  
                style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: buttonColor,minimumSize: Size(double.infinity, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: (){}, child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
              )
          ],
        ),
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
                      onPressed: (){}, child: Text('Re-Order',style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  )
                  
                                    
                          ],
                    ),
                  )
                    ],
                  ),
                 
                ],
              ),
            );
          }),
          SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('How is Your order?',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  divider,
            Text('your overall rating',style: TextStyle(fontSize: 16),),
            SizedBox(height: 10),
            RatingBar.builder(
   initialRating: 0,
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
divider,
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 15),
  child:   TextField(
    maxLines: 6,
    decoration: InputDecoration(
      hintText: 'Enter here',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
    ),
  ),
),
              ],
            ),
            SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                
              },
              child: Row(
                children: [
                  Icon(CupertinoIcons.camera),SizedBox(width: 5),Text('add photo',style: subtitle,)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}