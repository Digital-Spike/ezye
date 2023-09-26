import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: buttonColor),
        title: Text('History',style: apptitle,),
        centerTitle: true,
      ),
    );
  }
}