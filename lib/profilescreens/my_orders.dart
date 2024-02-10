import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/order.dart';
import 'package:ezye/orderscreens/order_detail_screen.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/util/order_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late Future orderListFuture;
  List<Order> orderList = [];

  @override
  void initState() {
    orderListFuture = getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Orders',
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
      body: FutureBuilder<void>(
        future: orderListFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (orderList.isEmpty) {
              return const Center(
                child: Text("No orders found!"),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    Order order = orderList[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 0.5, color: const Color(0xffE8E9EE))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${order.orderId}',
                                  ),
                                  Text(
                                    '${order.created}',
                                    style: const TextStyle(
                                        color: Color(0xffBDC1CA)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/checkgreen.svg'),
                                  const SizedBox(width: 5),
                                  Text(
                                      '${OrderUtil.instance.getOrderStatus(status: (order.status ?? "").toLowerCase())}')
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color:
                                    const Color(0xffE8E9EE).withOpacity(0.3)),
                            child: Text(
                              'Products ( ${(order.items ?? []).length} )',
                              style: const TextStyle(color: Color(0xff7C7D85)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: (order.items ?? []).length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  OrderItem item = (order.items ?? [])[index];
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
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${ApiService.uploads}${item.productId}01.jpg',
                                              placeholder: (context, url) =>
                                                  const CircleAvatar(
                                                backgroundColor: Colors.white30,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Image.asset(
                                                  'assets/png/cloth.png',
                                                  fit: BoxFit.contain,
                                                  height: 90,
                                                ),
                                              ),
                                              imageBuilder: (context, image) =>
                                                  Image(
                                                image: image,
                                                height: 90,
                                                fit: BoxFit.contain,
                                              ),
                                            )),
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
                                            Text(
                                              'SIZE: ${item.size}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffBDC1CA)),
                                            ),
                                            const SizedBox(height: 10),
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
                                                          color:
                                                              Color(0xffBDC1CA),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    Text(
                                                      '₹ ${item.amount}',
                                                      style: const TextStyle(
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
                                                          BorderRadius.circular(
                                                              5),
                                                      color: const Color(
                                                          0xff00CA14)),
                                                  child: Text(
                                                    '${item.discount ?? ''}% Off',
                                                    style: const TextStyle(
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
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  minimumSize: const Size(double.infinity, 38)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetail(
                                              order: orderList[index],
                                            )));
                              },
                              child: const Text(
                                'View Details',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ))
                        ],
                      ),
                    );
                  }),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> getOrderList() async {
    String bookmarkUrl = "${ApiService.url}getOrderList.php";
    var order = await http.post(Uri.parse(bookmarkUrl), body: {
      "userId": Provider.of<SessionObject>(context, listen: false).user.userId
    });
    orderList = (json.decode(order.body) as List)
        .map((item) => Order.fromJson(item))
        .toList();
  }
}
