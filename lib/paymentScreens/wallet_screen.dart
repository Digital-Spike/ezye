import 'package:ezys/homescreens/main_screen.dart';
import 'package:flutter/material.dart';
class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(),
      mainChild: Column());
  }
}