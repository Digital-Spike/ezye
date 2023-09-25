import 'dart:convert';

import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/homescreens/cart_screen.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:ezys/homescreens/wishlist_screen.dart';
import 'package:ezys/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
   bool _showCircle = false;
   String?name,
   category,
   subCategory,
   MRP,
   sellingPrice,
   productId,
   description,
   fullDescription,
   imageUrl,
   size,
   color,
   stock_status,
   stock_number;
  int selectedThumbnailIndex = 0; // Track the selected thumbnail index
  int counter = 0;
  bool showOriginalContainer = false;
  
  int selectedColorIndex = 0; // Initialize with -1, meaning no color selected
  String? selectedColorName;
  bool isLiked = false;

  List<String> clothingImages = [
    'assets/t.jpg',
    'assets/t1.jpg',
    'assets/t2.jpg',
    'assets/t3.jpg',
  ];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];
  List<String> colorNames = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Purple',
  ];

  // Function to update the selected color
  void selectColor(int index) {
    setState(() {
      selectedColorIndex = index;
      selectedColorName = colorNames[index];
    });
  }

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
          if (counter == 0) {
            // Display the bottom modal sheet
            
          }
        }
      }
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();

    // Set the initial selected color to the first color in the list
    selectedColorName = colorNames[selectedColorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xfff1f1f2),
        appBar: AppBar(
          title: Text(
            'Product Details',
            style: apptitle,
          ),
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(30, 30),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WishList()));
                },
                child: Image.asset(
                  'assets/icons/love.png',
                  height: 27,
                  width: 27,
                )),
            TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(30, 30),
                ),
                onPressed: () {},
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                )),
            TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(30, 30),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen(image: clothingImages[selectedThumbnailIndex], title: 'Tiger Image EZYE – Tees for Men', size: size ?? 'Not selected', price: '₹399', counter: counter,)));
                },
                child: Image.asset(
                  'assets/icons/shoppingbag.png',
                  height: 27,
                  width: 27,
                )),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
              border: Border.all(width: 0.5, color: Colors.grey),
              //     boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.2), // Shadow color
              //     spreadRadius: 3, // Spread radius
              //     blurRadius: 3, // Blur radius
              //     offset: Offset(0, 1), // Offset in the vertical direction (adjust as needed)
              //   ),
              // ],
              color: Colors.white),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen(image: clothingImages[selectedThumbnailIndex], title: 'Tiger Image EZYE – Tees for Men', size: size ?? 'Not selected', price: '₹399', counter: counter,)));
                  },
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.cart_fill_badge_plus),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Main clothing image
                  GestureDetector(
                    onTap: () {
                      // Handle tapping on the main image (optional)
                    },
                    child: Image.asset(
                      clothingImages[selectedThumbnailIndex],
                      // height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Small thumbnail images stacked on top-left
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: clothingImages.asMap().entries.map((entry) {
                        final index = entry.key;
                        final imagePath = entry.value;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedThumbnailIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedThumbnailIndex == index
                                    ? Colors.orange
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Image.asset(isLiked
                                ? 'assets/icons/heart (2).png'
                                : 'assets/icons/love.png')),
                      ))
                ],
              ),
              Divider(
                height: 0.25,
                color: Colors.grey[200],
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'T-shirt',
                            style: content,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('4.9'),
                              SizedBox(width: 5),
                              Text('Ratings')
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Tiger Image EZYE – Tees for Men',
                            style: title),
                      ),
                      SizedBox(height: 5),
                      Text('Price', style: subtitle),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                sellingPrice.toString(),
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.green[800],
                                    decorationColor: Colors.green[800],
                                    decorationThickness: 3),
                              ),
                              Text('- ${MRP.toString()}'),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                              onTap: toggleContainer,
                              child: Container(
                               
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade200)),
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
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: buttonColor),
                                        child: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              // : Container(
                              //     height: 35,
                              //     width: 110,
                              //     decoration: BoxDecoration(
                              //         color: Colors.grey[200],
                              //         borderRadius:
                              //             BorderRadius.circular(12),
                              //         border: Border.all(
                              //             width: 0.5,
                              //             color: Colors.grey.shade400)),
                              //     child: Center(
                              //       child: Text(
                              //         counter == 0 ? "Add" : "$counter",
                              //         style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w900,
                              //             color: Colors.green[600]),
                              //       ),
                              //     ),
                              //   )

                              ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Wrap(spacing: 10, children: [
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: Colors.grey,
                            selectedColor: buttonColor,
                            label: const Text(
                              'S',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: size == 'S',
                            onSelected: (selected) {
                              setState(() {
                                size = selected ? 'S' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: Colors.grey,
                            selectedColor: buttonColor,
                            label: const Text(
                              'M',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: size == 'M',
                            onSelected: (selected) {
                              setState(() {
                                size = selected ? 'M' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: Colors.grey,
                            selectedColor: buttonColor,
                            label: const Text(
                              'L',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: size == 'L',
                            onSelected: (selected) {
                              setState(() {
                                size = selected ? 'L' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: Colors.grey,
                            selectedColor: buttonColor,
                            label: const Text(
                              'XL',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: size == 'XL',
                            onSelected: (selected) {
                              setState(() {
                                size = selected ? 'XL' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            backgroundColor: Colors.grey,
                            selectedColor: buttonColor,
                            label: const Text(
                              'XXL',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: size == 'XXL',
                            onSelected: (selected) {
                              setState(() {
                                size = selected ? 'XXL' : '';
                              });
                            },
                          ),
                        ]),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Selected Color: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(color.toString(),
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 50, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectColor(index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(0),
                                margin: EdgeInsets.all(8),
                                width: 40,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[index],
                                  border: selectedColorIndex == index
                                      ? Border.all(
                                          color: Colors
                                              .black, // Add your desired stroke color
                                          width:
                                              2, // Adjust the stroke width as needed
                                        )
                                      : null, // No border when not selected
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 5),
                      DefaultTabController(
                          length: 2, // Number of tabs
                          child: Column(children: [
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              tabs: [
                                Tab(text: 'About Item'), // First tab
                                Tab(text: 'Reviews'), // Second tab
                              ],
                            ),
                            Container(
                              height:
                                  200, // Set the height of the TabBarView as needed
                              child: const TabBarView(
                                children: [
                                  SingleChildScrollView(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'DESCRIPTION',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Specifications of Graphic Printed Cotton Half Sleeves Round Neck T-Shirt',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'A graphic printed t-shirt is a type of casual shirt that features a unique design, image, or text printed on the front. These shirts are typically made of soft and comfortable materials such as a cotton blend, which allows for easy movement and breathability. These shirts are popular among all age groups and genders and can be worn in a variety of settings, including casual outings. Graphic printed t-shirts are a fun and expressive way to showcase your personality and style.',
                                        textAlign: TextAlign.justify,
                                      )
                                    ],
                                  )),
                                  SingleChildScrollView(
                                    child: Center(
                                      child: Text('Reviews Tab Content'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
Future<void> fetchData() async {
  const url = 'https://ezys.in/customerApp/getProductDetails.php'; // Replace with your API URL

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response here and assign values to your variables.
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        name = data['name'];
        category = data['category'];
        subCategory = data['subCategory'];
        MRP = data['MRP'];
        sellingPrice = data['sellingPrice'];
        productId = data['productId'];
        description = data['description'];
        fullDescription = data['fullDescription'];
        imageUrl = data['imageUrl'];
        size = data['size'];
        color = data['color'];
        stock_status = data['stock_status'];
        stock_number = data['stock_number'];
      });
    } else {
      // Handle errors if the API request was not successful.
      // You can show an error message or perform other actions here.
      print('API request failed with status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle exceptions if any occur during the API request.
    print('Error: $error');
  }
}


 
}
