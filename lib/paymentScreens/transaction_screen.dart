import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/model/transaction.dart';
import 'package:ezys/services/wallet_service.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Future<List<WalletTransactions>> transactions;

  @override
  void initState() {
    transactions = getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const BackButton(color: buttonColor),
          title: const Text(
            'History',
            style: apptitle,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<WalletTransactions>>(
            future: transactions,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<WalletTransactions> transactions = snapshot.data;
                if (!snapshot.hasData) {
                  return const Text('No transactions found!');
                }

                return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      WalletTransactions transaction = transactions[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              ((transaction.status ?? '') == 'PURCHASE')
                                  ? Icons.shopping_cart_sharp
                                  : Icons.handshake,
                              size: 40,
                            ),
                            title: Text('Amount: ${transaction.amount ?? ""}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(transaction.reference ?? ''),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(transaction.created ?? ''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
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

  Future<List<WalletTransactions>> getTransactions() async {
    return await WalletService.getWalletTransaction();
  }
}
