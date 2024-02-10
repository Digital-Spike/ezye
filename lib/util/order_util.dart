import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderUtil {
  OrderUtil._();

  static final OrderUtil instance = OrderUtil._();

  Widget getOrderStatus({required String status}) {
    if (status == 'ORDER PLACED') {
      return Row(
        children: [
          SvgPicture.asset('assets/svg/checkgreen.svg'),
          const SizedBox(width: 5),
          const Text('Order Placed')
        ],
      );
    }

    if (status == 'purchased') {
      return Row(
        children: [
          SvgPicture.asset('assets/svg/checkgreen.svg'),
          const SizedBox(width: 5),
          const Text('Delivered')
        ],
      );
    }
    if (status == "cancelled") {
      return Row(
        children: [
          SvgPicture.asset('assets/svg/cancel_icon.svg'),
          const SizedBox(width: 5),
          const Text('Cancelled'),
        ],
      );
    }
    if (status == 'return') {
      return Row(
        children: [
          SvgPicture.asset('assets/svg/spinner.svg'),
          const SizedBox(width: 5),
          const Text('Returned & Refunded')
        ],
      );
    }

    return Container();
  }
}
