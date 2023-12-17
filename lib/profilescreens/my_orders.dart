import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/order.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late Future<void> orderFuture;
  List<Order> ordersList = [];

  @override
  void initState() {
    orderFuture = getMyOrders();
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
            future: orderFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (ordersList.isEmpty) {
                  return const Text('No orders found!');
                }
                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      shrinkWrap: true,
                      itemCount: ordersList.length,
                      itemBuilder: (context, index) {
                        Order order = ordersList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(Icons.local_shipping_outlined),
                            title: Text('Order id: ${order.orderId}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Address: ${order.address}'),
                                Text('Created on: ${order.created}'),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Text(
                    'Something went wrong. Please try again later');
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future<void> getMyOrders() async {
    try {
      var ordersUrl = Uri.parse('${ApiService.url}getOrderList.php');
      var reqBody = {"userId": FirebaseUser.user?.uid};

      var response = await http.post(ordersUrl, body: reqBody);
      if (response.statusCode == 200) {
        ordersList = (json.decode(response.body) as List)
            .map((item) => Order.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
