import 'package:ezys/main_screen.dart';
import 'package:ezys/multiselectchoicechip.dart';
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
  String?sizes;
    int selectedColorIndex = -1; // Initialize with -1, meaning no color selected


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

  // Function to update the selected color
  void selectColor(int index) {
    setState(() {
      selectedColorIndex = index;
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
  });
}
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: (){}, child: Image.asset('assets/icons/heart.png',height: 25,width: 25,)),TextButton(onPressed: (){}, child: Icon(Icons.share,color: Colors.black,)),TextButton(onPressed: (){}, child: Image.asset('assets/icons/shoppingbag.png',height: 25,width: 25,))
        ],
      ),
      mainChild: SafeArea(
        child: SingleChildScrollView(
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
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
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
            Divider(height: 0.25,color: Colors.grey[200],),
          Container(
            color: Colors.white,
           
           width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Tiger Image EZYE – Tees for Men',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
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
                                color: Colors.black, // Add your desired stroke color
                                width: 2, // Adjust the stroke width as needed
                              )
                            : null, // No border when not selected
                      ),
                    ),
                  );
                },
              ),
            ),
           SizedBox(height: 5),
            
               
          
        
      
                  Text('Price', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                   Row(
                                children: [
                                  Text('₹799',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.green[800],decorationColor: Colors.green[800],decorationThickness: 2),),SizedBox(width: 5),
                                  Text('- ₹399'),SizedBox(width: 10), Row(children: [Icon(Icons.star,color: Colors.amber,),SizedBox(width: 5,),Text('4.9'),SizedBox(width: 5),Text('Ratings')],),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Wrap(spacing: 10, children: [
                                              ChoiceChip(
                                              backgroundColor: Colors.grey,
                                              selectedColor: Colors.blueGrey,
                                              label: const Text(
                                                'S',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              selected:
                                                  sizes == 'S',
                                              onSelected: (selected) {
                                                setState(() {
                                                  sizes = selected
                                                      ? 'S'
                                                      : '';
                                                });
                                              },
                                              ),
                                              ChoiceChip(
                                               
                                                
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'M',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    sizes == 'M',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    sizes = selected
                                                        ? 'M'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'L',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    sizes == 'L',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    sizes = selected
                                                        ? 'L'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'XL',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    sizes == 'XL',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    sizes = selected
                                                        ? 'XL'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'XXL',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    sizes == 'XXL',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    sizes = selected
                                                        ? 'XXL'
                                                        : '';
                                                  });
                                                },
                                              ),
                                            ]),
                                          ),
                              SizedBox(height: 10),
                  GestureDetector(
                    onTap: toggleContainer,
                    child: showOriginalContainer
                            ? Container(
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
                              )
                            : Container(
                                height: 35,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(width: 1.5, color: Colors.green.shade400),
                                ),
                                child: Center(
                                  child: Text(
                                    counter == 0 ? "Add" : "$counter",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.green[600]),
                                  ),
                                ),
               ) ),
               SizedBox(height: 5),
              
              
               DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: [
                  TabBar(
                    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: 'About Item'), // First tab
                      Tab(text: 'Reviews'), // Second tab
                    ],
                  ),
                  Container(
                    height: 200, // Set the height of the TabBarView as needed
                    child: const TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text('DESCRIPTION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text('Specifications of Graphic Printed Cotton Half Sleeves Round Neck T-Shirt',style: TextStyle(fontWeight: FontWeight.w600),),
                              SizedBox(height: 5),
                              Text('A graphic printed t-shirt is a type of casual shirt that features a unique design, image, or text printed on the front. These shirts are typically made of soft and comfortable materials such as a cotton blend, which allows for easy movement and breathability. These shirts are popular among all age groups and genders and can be worn in a variety of settings, including casual outings. Graphic printed t-shirts are a fun and expressive way to showcase your personality and style.',textAlign: TextAlign.justify,)
                            ],
                          )
                        ),
                        SingleChildScrollView(
                          child: Center(
                            child: Text('Reviews Tab Content'),
                          ),
                        ),
                      ],
                    ),
               
              )]))],
              ),
            ),
          ),
         
            ],
          ),
        ),
      ));
  }
}