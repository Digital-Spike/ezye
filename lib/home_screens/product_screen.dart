import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ezye/home_screens/cart_screen.dart';
import 'package:ezye/model/product.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product? product;
  bool selectedSize = false;
  String size = '';
  int? _value = -1;
  List<String> imgList = [];
  List<Product> bookmarkList = [];
  int currentIndex = 0;
  List<Color> colors = [
    const Color(0xff243B4C),
    const Color(0xff000000),
    const Color(0xff8C969D),
  ];
  int selectedColorIndex = 0;
  List<String> sizes = ['S', 'M', 'L', 'XL'];
  List<String> colorNames = [
    'Blue',
    'Black',
    'Grey',
  ];
  String? selectedColorName;
  void selectColor(int index) {
    setState(() {
      selectedColorIndex = index;
      selectedColorName = colorNames[index];
    });
  }

  int itemCount = 1;
  void incrementCounter() {
    setState(() {
      itemCount++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (itemCount > 0) {
        itemCount--;
      }
    });
  }

  Future<bool>? listItems;
  @override
  void initState() {
    listItems = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: listItems,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.2)),
                      child: const BackButton()),
                  actions: [
                    GestureDetector(
                        onTap: () async {
                          showProcessingDialogue();
                          isSaved()
                              ? await addToWishlist()
                              : await removeFromWishlist();
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                          setState(() {});
                        },
                        child: SvgPicture.asset(
                          isSaved()
                              ? 'assets/svg/heart.svg'
                              : 'assets/svg/redheart.svg',
                          height: 30,
                        )),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.2)),
                      child: SvgPicture.asset('assets/svg/cart.svg'),
                    ),
                  ],
                ),
                extendBodyBehindAppBar: true,
                bottomNavigationBar: BottomAppBar(
                  elevation: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  width: 0.1, color: Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      decrementCounter();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg/minus.svg',
                                      height: 50,
                                    )),
                                Text(
                                  itemCount.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      incrementCounter();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/svg/add.svg',
                                      height: 50,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  minimumSize: const Size(double.infinity, 56),
                                  side: const BorderSide(
                                      width: 1.5, color: Colors.black)),
                              onPressed: () async {
                                showProcessingDialogue();
                                bool isAddedToCart = await addToCart();
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartPage()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(isAddedToCart
                                        ? "Item added to cart successfully.."
                                        : "Something went wrong. please try again later.."),
                                    backgroundColor: isAddedToCart
                                        ? Colors.green
                                        : Colors.redAccent,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add to cart',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          width: double.infinity,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemCount: imgList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiService.uploads}${imgList[index]}',
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    backgroundColor: Colors.white30,
                                  ),
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.asset(
                                      'assets/png/cloth.png',
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
                              );
                            },
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width / 2.5,
                            bottom: 10,
                            child: DotsIndicator(
                              decorator: DotsDecorator(
                                  color: Colors.white.withOpacity(0.3),
                                  activeColor: Colors.white),
                              dotsCount: imgList.length,
                              position: currentIndex,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black),
                            child: const Text(
                              'EZYE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product?.name ?? '',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '₹${product?.mrp}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff7C7D85),
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '₹${product?.sellingPrice}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff00CA14)),
                                child: const Text(
                                  '10% Off',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Colors',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectColor(index);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 65,
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: selectedColorIndex == index
                                              ? Border.all(
                                                  color: Colors.black,
                                                  // Add your desired stroke color
                                                  width:
                                                      1.5, // Adjust the stroke width as needed
                                                )
                                              : null,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),

                                            color: colors[index],
                                            // No border when not selected
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        colorNames[index],
                                        style: TextStyle(
                                            color: selectedColorIndex == index
                                                ? const Color(0xff040707)
                                                : const Color(0xff7C7D85)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Sizes',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (context, index) {
                                  return ChoiceChip(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    label: Container(
                                      height: 30,
                                      width: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        sizes[index],
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                        color: _value == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16),
                                    selected: _value == index,
                                    backgroundColor: _value == index
                                        ? Colors.black
                                        : const Color(0xffE8E9EE),
                                    onSelected: (selected) {
                                      setState(() {
                                        _value = index;
                                      });
                                    },
                                  );
                                },
                              )),
                          const SizedBox(height: 5),
                          const Text('About Product',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 5),
                          Text(
                            '${product?.fullDescription}',
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff3E3E41)),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    )
                  ],
                )));
          }

          if (snapshot.hasError || snapshot.data == false) {
            return const Text("Something went wrong. Please try again later");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<bool> fetchData() async {
    try {
      if (SessionObject.user.userId != null) {
        await getWishList();
      }

      var productUrl = Uri.parse('${ApiService.url}/getProductDetails.php');
      var response =
          await http.post(productUrl, body: {"productId": widget.productId});

      if (response.statusCode == 200) {
        product = (json.decode(response.body) as List)
            .map((item) => Product.fromJson(item))
            .toList()
            .first;
        if ((product?.image1Url ?? '').isNotEmpty) {
          imgList.add(product?.image1Url ?? '');
        }
        if ((product?.image2Url ?? '').isNotEmpty) {
          imgList.add(product?.image2Url ?? '');
        }
        if ((product?.image3Url ?? '').isNotEmpty) {
          imgList.add(product?.image3Url ?? '');
        }
        if ((product?.image4Url ?? '').isNotEmpty) {
          imgList.add(product?.image4Url ?? '');
        }
        if ((product?.image5url ?? '').isNotEmpty) {
          imgList.add(product?.image5url ?? '');
        }
      }

      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  Future<bool> addToCart() async {
    try {
/*      await getCartItems();

      List<CartItem> cartItem = cartItems
          .where((element) => element.productId == product?.productId)
          .toList();

      if (cartItem.isNotEmpty) {
        previousCartQty = int.parse(cartItems.first.quantity.toString());
        await updateCartQuantity();
        return true;
      }*/

      var addToCartUrl = Uri.parse('${ApiService.url}/addCart.php');
      var reqBody = {
        "userId": FirebaseUser.user?.uid ?? '',
        "productId": product?.productId,
        "productName": product?.name,
        "size": product?.size,
        "color": product?.color,
        "amount": getTotalPrice(),
        "cartId": SessionObject.user.cartId ?? "",
        "quantity": itemCount.toString(),
        "imageUrl": product?.image1Url
      };

      var response = await http.post(addToCartUrl, body: reqBody);
      if (response.statusCode == 200) {
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  getTotalPrice() {
    double itemTotal = double.parse(product?.sellingPrice ?? "") * itemCount;
    return itemTotal.toString();
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

  Future<void> getWishList() async {
    String bookmarkUrl = "${ApiService.url}getUserWishlist.php";
    var bookmarkResponse = await http
        .post(Uri.parse(bookmarkUrl), body: {"userId": auth.currentUser?.uid});
    bookmarkList = (json.decode(bookmarkResponse.body) as List)
        .map((item) => Product.fromJson(item))
        .toList();
  }

  bool isSaved() {
    List<Product> list = bookmarkList
        .where((element) => element.productId == product?.productId)
        .toList();
    return list.isEmpty;
  }

  Future<bool> removeFromWishlist() async {
    try {
      var removeFromWishlistUrl =
          Uri.parse('${ApiService.url}/removeWishlist.php');
      var reqBody = {
        "userId": FirebaseUser.user?.uid ?? '',
        "productId": product?.productId
      };

      var response = await http.post(removeFromWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        await getWishList();
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addToWishlist() async {
    try {
      var addToWishlistUrl = Uri.parse('${ApiService.url}/wishList.php');
      var reqBody = {
        "userId": FirebaseUser.user?.uid ?? '',
        "productId": product?.productId,
        "name": product?.name,
        "category": product?.category,
        "subCategory": product?.subCategory,
        "MRP": product?.mrp,
        "sellingPrice": product?.sellingPrice,
        "description": product?.description,
      };

      var response = await http.post(addToWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        await getWishList();
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
