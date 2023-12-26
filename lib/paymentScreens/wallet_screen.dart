import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/transaction.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/wallet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late Future<List<WalletTransactions>> transactions;

  @override
  void initState() {
    transactions = getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: const BackButton(color: Colors.white),
          title: const Text(
            'My Wallet',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${SessionObject.user.walletBalance}',
                      style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const Text(
                      'Available Balance',
                      style: TextStyle(fontSize: 18, color: Color(0xffBDC1CA)),
                    ),
                    Text(
                      '${getWalletBalance()}',
                      style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 60),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          children: [
                            Text(
                              '3,000',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              'Total Earnings',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffBDC1CA)),
                            )
                          ],
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 1,
                          height: 50,
                          color: const Color(0xff7C7D85),
                        ),
                        const SizedBox(width: 15),
                        const Column(
                          children: [
                            Text(
                              '2,000',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              'Total Spent',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffBDC1CA)),
                            )
                          ],
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xffE8E9EE).withOpacity(0.3)),
                  child: const Text(
                    'Transactions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              FutureBuilder<List<WalletTransactions>>(
                  future: transactions,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<WalletTransactions> transactions = snapshot.data;

                      if (!snapshot.hasData || transactions.isEmpty) {
                        return const Text('No transactions found!');
                      }
                      return Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              primary: true,
                              shrinkWrap: true,
                              itemCount: transactions.length,
                              itemBuilder: (context, index) {
                                WalletTransactions transaction =
                                    transactions[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        const Color(0xffE8E9EE)
                                                            .withOpacity(0.4)),
                                                child: const Icon(
                                                    CupertinoIcons.clock_fill),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ((transaction.status ??
                                                                '') ==
                                                            'PURCHASE')
                                                        ? 'Earned from order'
                                                        : 'Earned from reference',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    '${transaction.created}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff7C7D85)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '${transaction.amount}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff00CA14)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      devider
                                    ],
                                  ),
                                );
                              }),
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
                  })
            ],
          ),
        ));
  }

  Future<List<WalletTransactions>> getTransactions() async {
    return await WalletService.getWalletTransaction();
  }

  getWalletBalance() {
    if((SessionObject.user.walletBalance ?? '').isNotEmpty){
      return (SessionObject.user.walletBalance ?? '');
    }
    return '0';
  }
}
