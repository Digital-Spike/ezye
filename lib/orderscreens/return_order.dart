import 'package:easy_stepper/easy_stepper.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/orderscreens/confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReturnOrder extends StatefulWidget {
  const ReturnOrder({Key? key}) : super(key: key);

  @override
  State<ReturnOrder> createState() => _ReturnOrderState();
}

class _ReturnOrderState extends State<ReturnOrder> {
  int currentStep = 0;
 
  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  bool checkboxValues = false;
  int count = 1;
  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Return Order',
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
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2, color: Colors.black),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      cancelStep();
                      print(currentStep);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )),
              ),
              const SizedBox(width: 20),
              if (currentStep < 2)
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.black),
                      onPressed: () {
                        continueStep();
                        print(currentStep);
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                ),
              if (currentStep == 2)
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.black),
                      onPressed: () {
                        continueStep();
                        print(currentStep);
                        if (currentStep == 2) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmationScreen(
                                      title: 'Your return has been requested!',
                                      subtitle:
                                          'Once the product is returned, the refunded amount will be credited to your EZYE wallet.',
                                      image: 'assets/png/return.png',
                                      svgpath: 'assets/svg/returnorder.svg')));
                        }
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                )
            ],
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 0),
                color: Colors.black,
                child: EasyStepper(
                  activeStep: currentStep,
                  lineStyle: LineStyle(
                    lineLength: 120,
                    lineSpace: 0,
                    lineType: LineType.normal,
                    activeLineColor:
                        currentStep < 0 ? Colors.white : Color(0xff7C7D85),
                    defaultLineColor: Color(0xff7C7D85),
                    finishedLineColor: Colors.white,
                    lineThickness: 1.5,
                  ),
                  unreachedStepBackgroundColor: Colors.grey,
                  unreachedStepTextColor: Colors.grey,
                  activeStepTextColor: Colors.white,
                  finishedStepTextColor: Colors.white,
                  internalPadding: 0,
                  showLoadingAnimation: false,
                  stepRadius: 10,
                  showStepBorder: false,
                  steps: [
                    EasyStep(
                      customStep: Container(
                        color: Colors.black,
                        child: Icon(
                          currentStep >= 1
                              ? CupertinoIcons.checkmark_circle_fill
                              : CupertinoIcons.check_mark_circled,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      customTitle: const Text(
                        'Product\nSelection',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                    EasyStep(
                      customStep: Container(
                        color: Colors.black,
                        child: Icon(
                          currentStep >= 2
                              ? CupertinoIcons.checkmark_circle_fill
                              : CupertinoIcons.check_mark_circled,
                          color: currentStep >= 1
                              ? Colors.white
                              : Color(0xff7C7D85),
                          size: 20,
                        ),
                      ),
                      customTitle: Text(
                        'Pick-Up Location\nDetails',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: currentStep >= 1
                                ? Colors.white
                                : const Color(0xff7C7D85),
                            fontSize: 11),
                      ),
                    ),
                    EasyStep(
                      customStep: Container(
                        color: Colors.black,
                        child: Icon(
                          currentStep >= 3
                              ? CupertinoIcons.checkmark_circle_fill
                              : CupertinoIcons.check_mark_circled,
                          color: currentStep >= 2
                              ? Colors.white
                              : Color(0xff7C7D85),
                          size: 20,
                        ),
                      ),
                      customTitle: Text(
                        'Return\nConfirmation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: currentStep >= 2
                                ? Colors.white
                                : const Color(0xff7C7D85),
                            fontSize: 11),
                      ),
                    ),
                  ],
                  onStepReached: (index) => setState(() => currentStep = index),
                ),
              ),
              if (currentStep == 0)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 10, top: 10, bottom: 5),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          height: 100,
                                          width: 80,
                                          child: Image.asset(
                                            'assets/png/cloth.png',
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: const Text(
                                            'Men Blue Washed Denim Jacket men Blue',
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: 50,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'XL',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(width: 5),
                                              SvgPicture.asset(
                                                  'assets/svg/arrowdown.svg')
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        width: 0.1,
                                                        color: Colors
                                                            .grey.shade200),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            decrementCounter();
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/minus.svg',
                                                            height: 30,
                                                          )),
                                                      Text(
                                                        count.toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            incrementCounter();
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/add.svg',
                                                            height: 30,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Text(
                                                      '₹2,000',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        const Text(
                                                          '₹ 2,199',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xffBDC1CA),
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: const Color(
                                                                  0xff00CA14)),
                                                          child: const Text(
                                                            '10% Off',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 6,
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
                ),
              if (currentStep == 1)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 2,
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
                ),
              if (currentStep == 2)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffE8E9EE))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ORD02134567',
                            ),
                            const Text(
                              '07 Oct 2023  05:23 PM',
                              style: TextStyle(color: Color(0xffBDC1CA)),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color:
                                      const Color(0xffE8E9EE).withOpacity(0.3)),
                              child: const Text(
                                'Products(3)',
                                style: TextStyle(color: Color(0xff7C7D85)),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                height: 80,
                                                width: 60,
                                                child: Image.asset(
                                                  'assets/png/cloth.png',
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(width: 5),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.6,
                                                child: const Text(
                                                  'Men Blue Washed Denim Jacket men Blue',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                'SIZE: XL',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xffBDC1CA)),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Column(
                                                    children: [
                                                      Text(
                                                        '₹ 2,199',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xffBDC1CA),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                      Text(
                                                        '₹2,000',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color(
                                                            0xff00CA14)),
                                                    child: const Text(
                                                      '10% Off',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Text('Pickup Location',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black),
                            child: const Text(
                              'CHANGE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const Text(
                        '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                        style: TextStyle(color: Color(0xff7C7D85)),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Refund Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Refundable Amount',
                            style: TextStyle(color: Color(0xff7C7D85)),
                          ),
                          Text(
                            '₹ 2,000.00',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
