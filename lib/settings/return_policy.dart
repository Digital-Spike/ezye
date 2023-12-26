import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';

class ReturnPolicy extends StatefulWidget {
  const ReturnPolicy({super.key});

  @override
  State<ReturnPolicy> createState() => ReturnPolicyState();
}

class ReturnPolicyState extends State<ReturnPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Return Policy',
            style: apptitle,
          ),
          centerTitle: true,
          leading: const BackButton(color: buttonColor),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Return & Refund Policy\n"
              "In all such instances when a customer changed their mind, or the fabrics didn’t meet their set expectations, and wish to return part or whole of the order, Ezye.in shall accept the returns, given that returned products qualify the conditions mentioned in clause 1. In such cases, customer shall bear the full shipping charges, and there shall be no reverse pick-up facility to avail. The refund shall be processed within 5-7 days from the date of receipt of returned order back at the shipping source.\n\n"
              "Conditions of Returned Products\n"
              "The tags on the product should be intact.\n"
              "The product should be unwashed, unused, unstitched and in an undamaged condition.\n"
              "The item needs to be returned along with the original packaging.\n\n"
              "Exchange\n"
              "Any request of exchange shall be fulfilled subject to the availability of the fabric in the inventory on the date of receipt of returned order/products.\n"
              "Exchange of products shall be calculated on the net payable price of the item(s) and not on MRP.",
              textAlign: TextAlign.justify,
            ),
          ),
        ));
  }
}
