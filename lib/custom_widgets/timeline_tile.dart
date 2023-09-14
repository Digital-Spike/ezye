import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
class MyTimeLine extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final status;
  const MyTimeLine({super.key,required this.isFirst,required this.isLast,required this.isPast,required this.status});

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: isPast? Colors.black:Colors.grey,
      ),
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isPast? Colors.black:Colors.grey,
        iconStyle: IconStyle(iconData: Icons.done,color: Colors.white)
      ),
      endChild: status,
    );
  }
}