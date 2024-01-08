import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Privacy Policy',
            style: apptitle,
          ),
          centerTitle: true,
          leading: const BackButton(color: buttonColor),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 25,right: 25),
            child: Text(
              "Ezye.in is a venture of digital spike technologies takes the privacy of your information seriously. This Privacy Notice describes the types of personal information we collect from you through our stores, website (including sub-domains and microsites) and mobile applications. It also describes the purposes for which we collect that personal information, the other parties with whom we may share it and the measures we take to protect the security of your data. It also tells you about your rights and choices with respect to your personal information, and how you can contact us about our privacy practices."
              "You are advised to carefully read this Privacy Notice before using or availing any of our products and/or services.\n"
              "Why we need your information’s?\n"
              "The primary reason we gather information is for order processing, shipping and customer service.\n"
              "We may contact you to provide an update on your order, information regarding the shipping status or to clarify questions related to your order.\n"
              "We also need this information sometimes to improve our services.\n"
              "What Information Do We Collect?\n"
              "Your contact details such as customer name, email address phone number and shipping address.\n"
              "Your transaction or banking details such as credit card number, Cardholder name, expiration date and cvv or other information as required for online transaction.\n"
              "Changes To Privacy Policy\n"
              "Our privacy policy is subject to change time to time without notice.\n"
              "To make sure you are aware of the changes, please review this policy periodically.\n"
              "Also this privacy statement does not apply to our business partners, affiliates or other third parties.\n"
              "Ezye.in reserves the right to take any legal action against the fake customer if any fraudulent activity is identifed such as fake multiple order for fun purpose, multiple usage ,wrong claim of order etc",
              textAlign: TextAlign.justify,
            ),
          ),
        ));
  }
}
