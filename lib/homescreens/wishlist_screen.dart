import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
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

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          title: Text('My Wishlist', style: apptitle),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        mainChild: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                          onPressed: ((context) {}),
                          icon: CupertinoIcons.delete,
                          backgroundColor: Colors.red.shade300,
                          label: 'Remove')
                    ]),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage('assets/image1.jpeg'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tiger Image EZYE',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[200]),
                                            child: Image.asset(
                                              'assets/icons/heart (2).png',
                                              height: 20,
                                              width: 20,
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'T-shirt',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Size: XL',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price: ₹399',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                         
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                width: 0.5,
                                                color: Colors.grey.shade200),
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
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                                '$counter',
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ]));
  }
}
