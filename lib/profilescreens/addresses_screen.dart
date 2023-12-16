import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/profilescreens/add_address.dart';
import 'package:ezye/profilescreens/edit_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  int address = 1;
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
                    const Spacer(),
                  ],
                ),
              ),
            ),
          if (address >= 1)
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: ListView.builder(
                      itemCount: address,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset('assets/svg/location.svg'),
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
                              const Text(
                                '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                                style: TextStyle(color: Color(0xff7C7D85)),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditAddress()));
                                    },
                                    child: Container(
                                      height: 24,
                                      width: 63,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    onTap: () {},
                                    child: Container(
                                      height: 24,
                                      width: 83,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
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
                          ),
                        );
                      })),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size(double.infinity, 56)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAddress()));
                },
                child: const Text(
                  'Add Address',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
