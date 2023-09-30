import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/home_screens/cart_screen.dart';
import 'package:ezys/home_screens/wishlist_screen.dart';
import 'package:ezys/model/product.dart';
import 'package:ezys/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
   bool isLoggedIn = false;
  int selectedThumbnailIndex = 0; // Track the selected thumbnail index
  int counter = 0;
  bool showOriginalContainer = false;

  int selectedColorIndex = 0; // Initialize with -1, meaning no color selected
  String? selectedColorName;
  bool isLiked = false;
  List<Product> products = [];
  Product? product;
  String size = '';

  List<String> clothingImages = [];
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

  Future<bool>? listItems;

  @override
  void initState() {
    listItems = fetchData();
    super.initState();
    selectedColorName = colorNames[selectedColorIndex];
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
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: apptitle,
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(30, 30),
              ),
              onPressed: () {
                 if (isLoggedIn) {
                 
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WishList()));
                } else {
                
                  _showLoginDialog1();
                }
               
              },
              child: Image.asset(
                'assets/icons/heart.png',
                height: 27,
                width: 27,
              )),
          TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(30, 30),
              ),
              onPressed: () async {
                final box = context.findRenderObject() as RenderBox?;
             await Share.share('check out this product ',sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
);
              },
              child: const Icon(
                Icons.share,
                color: Colors.black,
              )),
          TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(30, 30),
              ),
              onPressed: () {
                 if (isLoggedIn) {
                  // User is logged in, navigate to the payment page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                } else {
                  // User is not logged in, show the login dialog
                  _showLoginDialog();
                }
                
              },
              child: Image.asset(
                'assets/icons/shoppingbag.png',
                height: 27,
                width: 27,
              )),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            border: Border.all(width: 0.5, color: Colors.grey),
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
                onPressed: () async {
                  showProcessingDialogue();
                  bool isAddedToCart = await addToCart();
                  if (!mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isAddedToCart
                          ? "Item added to cart successfully.."
                          : "Something went wrong. please try again later.."),
                      backgroundColor:
                          isAddedToCart ? Colors.green : Colors.redAccent,
                      elevation: 10,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(5),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.cart_fill_badge_plus),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add to Cart',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ))
          ],
        ),
      ),
      body: FutureBuilder<bool>(
          future: listItems,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
               if (products.isNotEmpty) {
              product = products.first;
              if ((product?.image1Url ?? '').isNotEmpty) {
                clothingImages.add(product?.image1Url ?? '');
              }
              if ((product?.image2Url ?? '').isNotEmpty) {
                clothingImages.add(product?.image2Url ?? '');
              }
              if ((product?.image3Url ?? '').isNotEmpty) {
                clothingImages.add(product?.image3Url ?? '');
              }
              if ((product?.image4Url ?? '').isNotEmpty) {
                clothingImages.add(product?.image4Url ?? '');
              }
              if ((product?.image5url ?? '').isNotEmpty) {
                clothingImages.add(product?.image5url ?? '');
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Main clothing image
                        GestureDetector(
                          onTap: () {
                            // Handle tapping on the main image (optional)
                          },
                          child: CachedNetworkImage(
                            imageUrl: '${ApiService.uploads}ezysp005547902.png',
                            placeholder: (context, url) => const CircleAvatar(
                              backgroundColor: Colors.white30,
                            ),
                            errorWidget: (context, url, error) => Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Image.asset(
                                'assets/image.jpeg',
                                height: 110,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                            imageBuilder: (context, image) => Image(
                              image: image,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                clothingImages.asMap().entries.map((entry) {
                              final index = entry.key;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedThumbnailIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
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
                                  child: /*getImage(
                                    imageName: entry.value,
                                  ),*/
                                      CachedNetworkImage(
                                    imageUrl:
                                        '${ApiService.uploads}ezysp005547901.png',
                                    placeholder: (context, url) =>
                                        const CircleAvatar(
                                      backgroundColor: Colors.white30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Image.asset(
                                        'assets/image.jpeg',
                                        height: 110,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    imageBuilder: (context, image) => Image(
                                      image: image,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
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
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(isLiked
                                  ? 'assets/icons/heart (2).png'
                                                : 'assets/icons/heart.png',),
                            ),
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
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product?.name ?? '',
                                  style: content,
                                ),
                                const Row(
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
                              child: Text(product?.description ?? "",
                                  style: title),
                            ),
                            const SizedBox(height: 5),
                            const Text('Price', style: subtitle),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '₹${product?.sellingPrice ?? ""}',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.green[800],
                                          decorationColor: Colors.green[800],
                                          decorationThickness: 3),
                                    ),
                                    Text('- ₹${product?.mrp}'),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                                const SizedBox(width: 5),
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
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey[300]),
                                            child: const Icon(
                                              CupertinoIcons.minus,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$counter',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            incrementCounter();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: buttonColor),
                                            child: const Icon(
                                              CupertinoIcons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('Selected Color: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(products.first.color ?? '',
                                    style: const TextStyle(fontSize: 16))
                              ],
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
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
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(8),
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
                            const SizedBox(height: 10),
                            const SizedBox(height: 5),
                            DefaultTabController(
                              length: 2, // Number of tabs
                              child: Column(
                                children: [
                                  const TabBar(
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
                                  SizedBox(
                                    height:
                                        200, // Set the height of the TabBarView as needed
                                    child: TabBarView(
                                      children: [
                                        SingleChildScrollView(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            const Text(
                                              'DESCRIPTION',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product?.description ?? '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              product?.fullDescription ?? '',
                                              textAlign: TextAlign.justify,
                                            )
                                          ],
                                        )),
                                        const SingleChildScrollView(
                                          child: Center(
                                            child: Text('Reviews Tab Content'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }else {
              return const Text("Product not found");
            }
          }

            if (snapshot.hasError || snapshot.data == false) {
              return const Text("Something went wrong. Please try again later");
            }

            return  Center(
              child: Image.asset('assets/Ezye gif 4.gif',height: 300,width: 250,),
            );
          }),
    );
  }

  Future<bool> fetchData() async {
    try {
      var productUrl = Uri.parse('${ApiService.url}/getProductDetails.php');
      var response =
          await http.post(productUrl, body: {"productId": widget.productId});

      if (response.statusCode == 200) {
        products = (json.decode(response.body) as List)
            .map((item) => Product.fromJson(item))
            .toList();
      }
      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  showProcessingDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Processing...',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
 void _showLoginDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
              const Text('Login Required!', style: TextStyle(color: indicator)),
          content: const Text('You need to log in to continue to Check Cart.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }
  void _showLoginDialog1() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Login Required!',
            style: TextStyle(color: indicator),
          ),
          content: const Text('You need to log in to Check Your Wishlist.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }
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
          if (counter == 0) {}
        }
      }
    });
  }

  Future<bool> addToCart() async {
    try {
      var addToCartUrl = Uri.parse('${ApiService.url}/addCart.php');
      var response = await http.post(addToCartUrl, body: {
        "userId": "123456",
        "productId": widget.productId,
        "productName": product?.name,
        "size": product?.size,
        "color": product?.color,
        "amount": product?.sellingPrice,
        "cartId": "cart123",
        "quantity": "4"
      });

      if (response.statusCode == 200) {
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void imageList(Product? product) {
    if ((product?.image1Url ?? '').isNotEmpty) {
      clothingImages.add(product?.image1Url ?? '');
    }
    if ((product?.image2Url ?? '').isNotEmpty) {
      clothingImages.add(product?.image2Url ?? '');
    }
    if ((product?.image3Url ?? '').isNotEmpty) {
      clothingImages.add(product?.image3Url ?? '');
    }
    if ((product?.image4Url ?? '').isNotEmpty) {
      clothingImages.add(product?.image4Url ?? '');
    }
    if ((product?.image5url ?? '').isNotEmpty) {
      clothingImages.add(product?.image5url ?? '');
    }
  }

}
