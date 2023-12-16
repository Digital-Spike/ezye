import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/address.dart';
import 'package:ezye/profilescreens/add_address.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  bool checkboxValues = false;
  var size, height, width;

  int selectedAddress = 0;

  Future<bool>? getAddressFuture;
  List<Address> addressList = [];

  @override
  void initState() {
    super.initState();
    getAddressFuture = getAddress();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return FutureBuilder<bool>(
      future: getAddressFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Select Address',
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
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  (addressList.isEmpty)
                      ? Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: Colors.black,
                                  minimumSize: const Size(double.infinity, 56)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddAddress()));
                              },
                              child: const Text(
                                'Add Address',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              )),
                        )
                      : Expanded(
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      width: 2, color: Colors.black),
                                  minimumSize: const Size(double.infinity, 56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              onPressed: () {},
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )),
                        ),
                  if (addressList.isNotEmpty) const SizedBox(width: 20),
                  if (addressList.isNotEmpty)
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Colors.black),
                          onPressed: () {
                            Navigator.pop(
                                context, addressList[selectedAddress]);
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )),
                    ),
                ])),
            body: Column(
              children: [
                if (addressList.isEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: width / 1.5),
                          SvgPicture.asset('assets/svg/cloud.svg'),
                          const SizedBox(height: 20),
                          const Text(
                            'Oops! No address found. Please add your address to ensure smooth product delivery!',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff7C7D85)),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            Address address = addressList[index];
                            return Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 40,
                                          right: 10,
                                          top: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/location.svg',
                                              height: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              (address.type ?? '')
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40,
                                            right: 10,
                                            top: 10,
                                            bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                      ),
                                      const SizedBox(height: 5),
                                      devider
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 5,
                                  child: /*Checkbox.adaptive(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    side: const BorderSide(
                                        width: 1, color: Colors.black),
                                    value: checkboxValues,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        checkboxValues = value!;
                                      });
                                    },
                                  ),*/
                                      Radio(
                                    activeColor: Colors.black,
                                    value: index,
                                    groupValue: selectedAddress,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedAddress = value ?? 0;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                side: const BorderSide(
                                    width: 1.5, color: Colors.black),
                                minimumSize: const Size(double.infinity, 56)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddAddress()));
                            },
                            child: const Text(
                              'Add Address',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == false) {
          return const Text("Something went wrong. Please try again later");
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<bool> getAddress() async {
    var removeFromWishlistUrl =
        Uri.parse('${ApiService.url}getUserAddress.php');
    var reqBody = {"userId": FirebaseUser.user?.uid ?? ''};

    var response = await http.post(removeFromWishlistUrl, body: reqBody);
    if (response.statusCode == 200) {
      addressList = (json.decode(response.body) as List)
          .map((item) => Address.fromJson(item))
          .toList();
    }

    return true;
  }
}
