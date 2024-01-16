import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/address.dart';
import 'package:ezye/profilescreens/add_address.dart';
import 'package:ezye/profilescreens/edit_address.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  int address = 1;

  Future<bool>? getAddressFuture;
  List<Address> addressList = [];

  @override
  void initState() {
    super.initState();
    getAddressFuture = getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Add Addresses',
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
        body: FutureBuilder<bool>(
          future: getAddressFuture,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  (addressList.isEmpty)
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                SvgPicture.asset('assets/svg/cloud.svg'),
                                const SizedBox(height: 20),
                                const Text(
                                  'Oops! No address found. Please add your address to ensure smooth product delivery!',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff7C7D85)),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: ListView.builder(
                                  itemCount: addressList.length,
                                  itemBuilder: (context, index) {
                                    Address address = addressList[index];
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/svg/location.svg'),
                                            const SizedBox(width: 15),
                                            const Text(
                                              'Addresses',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${address.line1}, ${address.line2}, ${address.city}, ${address.pinCode}.',
                                                style: const TextStyle(
                                                    color: Color(0xff7C7D85)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditAddress(
                                                              address: address,
                                                            )));
                                              },
                                              child: Container(
                                                height: 24,
                                                width: 63,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.black),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/svg/pencil.svg'),
                                                    const SizedBox(width: 3),
                                                    const Text(
                                                      'EDIT',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () async {
                                                showDialogue();
                                                await deleteAddress(
                                                    id: address.id ?? '');
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  getAddressFuture =
                                                      getAddress();
                                                });
                                              },
                                              child: Container(
                                                height: 24,
                                                width: 83,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black)),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.clear,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'DELETE',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        devider,
                                        const SizedBox(height: 15),
                                      ],
                                    );
                                  })),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddAddress(isAddAddress: true)));
                      },
                      child: const Text(
                        'Add Address',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              );
            }

            if (snapshot.hasError) {
              return const Text("Something wrong please try again later");
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<bool> getAddress() async {
    var removeFromWishlistUrl =
        Uri.parse('${ApiService.url}getUserAddress.php');
    var reqBody = {
      "userId": Provider.of<SessionObject>(context, listen: false).user.userId
    };

    var response = await http.post(removeFromWishlistUrl, body: reqBody);
    if (response.statusCode == 200) {
      addressList =
          (json.decode((response.body).toString().replaceAll('connected', ''))
                  as List)
              .map((item) => Address.fromJson(item))
              .toList();
    }

    return true;
  }

  Future<bool> deleteAddress({required String id}) async {
    try {
      var deleteAddress = Uri.parse('${ApiService.url}deleteAddress.php');
      var reqBody = {"id": id};

      var response = await http.post(deleteAddress, body: reqBody);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> showDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),
              Text('Processing....')
            ],
          ),
        );
      },
    );
  }
}
