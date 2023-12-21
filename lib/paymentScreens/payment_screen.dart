import 'dart:convert';

import 'package:ezye/constants/string_util.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/model/address.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:ezye/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final Address address;
  final String totalAmount;
  const PaymentPage(
      {super.key, required this.address, required this.totalAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        title: const Text(
          'Payment Method',
          style: apptitle,
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: buttonColor),
              onPressed: () async {
                showProcessingDialogue();
                bool isOrderPlaced = await placeOrder();
                if (!mounted) {
                  return;
                }
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage()),
                  ModalRoute.withName('/'),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isOrderPlaced
                        ? "Order placed successfully.."
                        : "Something went wrong. please try again later.."),
                    backgroundColor:
                        isOrderPlaced ? Colors.green : Colors.redAccent,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(5),
                  ),
                );
              },
              child: const Text('Confirm Payment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Options',
                style: title,
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: RadioMenuButton(
                    value: 0,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    child: const Text('Cash on delivery'),
                  ))
            ],
          ),
        ),
      ),
    );
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

  Future<bool> placeOrder() async {
    try {
      var createOrderUrl = Uri.parse('${ApiService.url}createOrder.php');
      var reqBody = {
        "cartId": SessionObject.user.cartId ?? "",
        "userId": FirebaseUser.user?.uid,
        "orderId": StringUtil.getRandomString(8),
        "totalAmount": widget.totalAmount,
        "paymentMethod": 'cash',
        "address":
            '${widget.address.line1}, ${widget.address.line2}, ${widget.address.city}, ${widget.address.pinCode}'
      };

      var response = await http.post(createOrderUrl, body: reqBody);
      if (response.statusCode == 200) {
        await UserService.updateUser();
        return !jsonDecode(
            (response.body).toString().replaceAll('connected', ''))['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
