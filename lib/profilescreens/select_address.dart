import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/profilescreens/add_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  bool checkboxValues = false;
  int address = 3;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
            if (address == 0)
              Expanded(
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
                              builder: (context) => const AddAdress()));
                    },
                    child: const Text(
                      'Add Address',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              ),
            if (address >= 1)
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.black),
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
            if (address >= 1) const SizedBox(width: 20),
            if (address >= 1)
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.black),
                    onPressed: () {},
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
          if (address == 0)
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
                      style: TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
          if (address >= 1)
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: address,
                      itemBuilder: (context, index) {
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
                                        const Text(
                                          'Addresses Name Goes Here',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 40,
                                        right: 10,
                                        top: 10,
                                        bottom: 5),
                                    child: Text(
                                      '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                                      style:
                                          TextStyle(color: Color(0xff7C7D85)),
                                      textAlign: TextAlign.left,
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
                              child: Checkbox.adaptive(
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

                                    print(value);
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
                                  builder: (context) => const AddAdress()));
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
}
