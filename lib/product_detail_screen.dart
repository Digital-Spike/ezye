import 'package:ezys/main_screen.dart';
import 'package:ezys/multiselectchoicechip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedThumbnailIndex = 0; // Track the selected thumbnail index
  int counter = 0;
  bool showOriginalContainer = false;
  String? sizes;
  int selectedColorIndex = -1; // Initialize with -1, meaning no color selected
  String selectedColorName = '';

  List<String> clothingImages = [
    'assets/image.jpeg',
    'assets/image1.jpeg',
    'assets/image.jpeg',
    'assets/image1.jpeg',
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
        }
      }

      // Check if "Add" button is tapped and show the modal sheet
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/icons/heart.png',
                  height: 25,
                  width: 25,
                )),
            TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                )),
            TextButton(
                onPressed: () {},
                child: Image.asset(
                  'assets/icons/shoppingbag.png',
                  height: 25,
                  width: 25,
                ))
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: Size(150, 45)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Check Out',
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
                            style: TextStyle(color: Colors.grey[700]),
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
                        child: Text(
                          'Tiger Image EZYE – Tees for Men',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Price',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '₹799',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.green[800],
                                    decorationColor: Colors.green[800],
                                    decorationThickness: 2),
                              ),
                              Text('- ₹399'),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                              onTap: toggleContainer,
                              child: showOriginalContainer
                                  ? Container(
                                      height: 35,
                                      width: 110,
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
                                    )
                                  : Container(
                                      height: 35,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              width: 0.5,
                                              color: Colors.grey.shade400)),
                                      child: Center(
                                        child: Text(
                                          counter == 0 ? "Add" : "$counter",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.green[600]),
                                        ),
                                      ),
                                    )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Wrap(spacing: 10, children: [
                          ChoiceChip(
                            backgroundColor: Colors.grey,
                            selectedColor: Colors.blueGrey,
                            label: const Text(
                              'S',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: sizes == 'S',
                            onSelected: (selected) {
                              setState(() {
                                sizes = selected ? 'S' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            backgroundColor: Colors.grey,
                            selectedColor: Colors.blueGrey,
                            label: const Text(
                              'M',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: sizes == 'M',
                            onSelected: (selected) {
                              setState(() {
                                sizes = selected ? 'M' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            backgroundColor: Colors.grey,
                            selectedColor: Colors.blueGrey,
                            label: const Text(
                              'L',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: sizes == 'L',
                            onSelected: (selected) {
                              setState(() {
                                sizes = selected ? 'L' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            backgroundColor: Colors.grey,
                            selectedColor: Colors.blueGrey,
                            label: const Text(
                              'XL',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: sizes == 'XL',
                            onSelected: (selected) {
                              setState(() {
                                sizes = selected ? 'XL' : '';
                              });
                            },
                          ),
                          ChoiceChip(
                            backgroundColor: Colors.grey,
                            selectedColor: Colors.blueGrey,
                            label: const Text(
                              'XXL',
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: sizes == 'XXL',
                            onSelected: (selected) {
                              setState(() {
                                sizes = selected ? 'XXL' : '';
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
                          Text(selectedColorName,
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

 
}
