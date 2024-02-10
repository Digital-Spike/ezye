// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/cart_item.dart';
import 'package:ezye/model/order.dart';
import 'package:ezye/orderscreens/confirmation_screen.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelOrder extends StatefulWidget {
  final Order order;
  const CancelOrder({super.key, required this.order});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  bool continueN = false;
  bool continueN1 = true;
  List<String> selectedItems = [];
  int count = 1;
  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cancel Order',
          style: apptitle,
        ),
        centerTitle: true,
        leading: const BackButton(color: buttonColor),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        continueN
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.check_mark_circled,
                        color: Colors.white,
                        size: 18,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: continueN
                              ? Colors.white
                              : const Color(0xff7C7D85),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.check_mark_circled,
                        color:
                            continueN ? Colors.white : const Color(0xff7C7D85),
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Product\nSelection',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Cancel\nConfirmation',
                      style: TextStyle(
                          color: continueN
                              ? Colors.white
                              : const Color(0xff7C7D85),
                          fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
          ),
          continueN
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffE8E9EE))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ORD02134567',
                            ),
                            const Text(
                              '07 Oct 2023  05:23 PM',
                              style: TextStyle(color: Color(0xffBDC1CA)),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color:
                                      const Color(0xffE8E9EE).withOpacity(0.3)),
                              child: const Text(
                                'Products(3)',
                                style: TextStyle(color: Color(0xff7C7D85)),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 80,
                                                width: 60,
                                                child: Image.asset(
                                                  'assets/png/cloth.png',
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(width: 5),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.6,
                                                child: const Text(
                                                  'Men Blue Washed Denim Jacket men Blue',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                'SIZE: XL',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffBDC1CA)),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Column(
                                                    children: [
                                                      Text(
                                                        '₹ 2,199',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xffBDC1CA),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      Text(
                                                        '₹2,000',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color(
                                                            0xff00CA14)),
                                                    child: const Text(
                                                      '10% Off',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Refund Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Refundable Amount',
                            style: TextStyle(color: Color(0xff7C7D85)),
                          ),
                          Text(
                            '₹ 2,000.00',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: (widget.order.items ?? []).length,
                      itemBuilder: (context, index) {
                        CartItem item = (widget.order.items ?? [])[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 10, top: 10, bottom: 5),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${ApiService.uploads}${item.variantId}01.jpg',
                                          placeholder: (context, url) =>
                                              const CircleAvatar(
                                            backgroundColor: Colors.white30,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Image.asset(
                                              'assets/png/cloth.png',
                                              fit: BoxFit.contain,
                                              height: 110,
                                              width: 80,
                                            ),
                                          ),
                                          imageBuilder: (context, image) =>
                                              Image(
                                            image: image,
                                            height: 110,
                                            width: 80,
                                            fit: BoxFit.contain,
                                          ),
                                        )),
                                    const SizedBox(width: 5),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            '${item.name}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: 50,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            '${item.size}',
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            /*Column(
                                              children: [
                                                Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        width: 0.1,
                                                        color: Colors
                                                            .grey.shade200),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            decrementCounter();
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/minus.svg',
                                                            height: 30,
                                                          )),
                                                      Text(
                                                        count.toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            incrementCounter();
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/add.svg',
                                                            height: 30,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),*/
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          '₹ ${item.mrp}',
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xffBDC1CA),
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                        Text(
                                                          '₹ ${item.amount}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Column(
                                                      // crossAxisAlignment:
                                                      //     CrossAxisAlignment
                                                      //         .end,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: const Color(
                                                                  0xff00CA14)),
                                                          child: Text(
                                                            '${item.discount} % Off',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
                              left: 5,
                              child: Checkbox.adaptive(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)),
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                side: const BorderSide(
                                    width: 1, color: Colors.black),
                                value: selectedItems.contains(item.productId),
                                onChanged: (bool? value) {
                                  if (!selectedItems.contains(item.productId)) {
                                    setState(() {
                                      selectedItems.add(item.productId ?? '');
                                    });
                                  } else {
                                    setState(() {
                                      selectedItems
                                          .remove(item.productId ?? '');
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.5, color: Colors.black),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {
                        setState(() {
                          if (continueN == false) {
                            Navigator.pop(context);
                          }
                          continueN = !continueN;
                        });
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      )),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {
                        setState(() {
                          if (continueN == true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfirmationScreen(
                                          title:
                                              'Your order has been canceled!',
                                          subtitle:
                                              'The refunded amount will be transferred to your EZYE wallet.',
                                          image: 'assets/png/cancelorder.png',
                                          svgpath: 'assets/svg/cancelorder.svg',
                                        )));
                          }
                          continueN = !continueN;
                        });
                      },
                      child: Text(
                        continueN ? 'Confirm' : 'Continue',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
