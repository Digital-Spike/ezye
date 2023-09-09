import 'package:ezys/homescreens/main_screen.dart';
import 'package:flutter/material.dart';
class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(),
      mainChild: Column());
  }
}