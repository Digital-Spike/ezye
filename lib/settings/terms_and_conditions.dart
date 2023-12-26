import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Terms & Conditions',
            style: apptitle,
          ),
          centerTitle: true,
          leading: const BackButton(color: buttonColor),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Welcome to Ezye.in There are some basic terms and conditions that you need to be aware of while making a purchase on Ezye.in, These Terms may be subject to amendment, So You should carefully read them prior to placing any order.\n "
              "If You have any questions about the Terms & Condition or the Privacy Policy, You may access our website or contact us through Mail.\n\n "
              "Terms of Use \n "
              "Access to and use of ezye.in and the products and service available through the website are subject to the following terms, conditions and notices\n "
              "User Account, Password, and Security\n"
              "You will receive a password and account designation upon completing the Website’s registration process. You are responsible for maintaining the confidentiality of the password and account, and are fully responsible for all activities that occur under your password or account. Ezye.in cannot and will not be liable for any loss or damage arising from your failure to comply with this.\n\n"
              "Copyright\n"
              "All content included on this site, such as text, graphics, logos, modeling, description, images, data compilations, and software, is the property of hamercop.com or its content suppliers. The compilation of all content on this site is the exclusive property of Ezye.in\n"
              "You may not use the Site for any of the following purposes:\n"
              "Disseminating any unlawful, harassing, libellous, abusive, threatening, harmful, vulgar, obscene, or otherwise objectionable material. Transmitting material that encourages conduct that constitutes a criminal offence or results in civil liability or otherwise breaches any relevant laws, regulations or code of practice.\n"
              "Gaining unauthorized access to other computer systems.\n"
              "Interfering with any other person’s use or enjoyment of the Site.\n"
              "Breaching any applicable laws;\n\n"
              "Interfering or disrupting networks or web sites connected to the Site.\n"
              "Making, transmitting or storing electronic copies of materials protected by copyright without the permission of the owner.\n"
              "Governing Law and Jurisdiction\n"
              "This User Agreement shall be construed in accordance with the applicable laws of India. The Courts at Bangalore shall have exclusive jurisdiction in any proceedings arising out of this agreement. Any dispute or difference either in interpretation or otherwise, of any terms of this User Agreement between the parties hereto, the same shall be referred to an independent arbitrator who will be appointed by IRCPL and his decision shall be final and binding on the parties hereto. The above arbitration shall be in accordance with the Arbitration and Conciliation Act, 1996 as amended from time to time. The arbitration shall be held in Bangalore. The High Court of judicature at Bangalore alone shall have the jurisdiction and the Laws of India shall apply.\n"
              "Shipping Cost:\n"
              "Shipping Cost is calculated on per product, which will be reflected on your checkout page.\n"
              "India / Domestic orders: Shipping cost is as per the packing size and its weight\n\n"
              "Shipping Time:\n"
              "Domestic orders: The products ordered can be expected to be delivered within 5-7 days in major metro cities in India and can take anywhere between 8-10 days for other locations in India, from the time the order is confirmed.\n\n"
              "Cancellation:\n"
              "You can cancel an order until it has not been shipped out of our Warehouse which is notified through an email within 24 to 48 hours from placing an order. This includes items purchased on sale also. Any amount paid shall be credited back into the requested bank account.\n"
              "You can modify the shipping address of your order before we have processed (packed) it, by calling us on our customer care number.\n"
              "You can cancel the order by calling us on the customer care number.\n"
              "If you had selected Cash on Delivery at the time of placing order, there is no amount to be refunded because you haven’t paid for your order. For payments made via Credit Card, Debit Card, Net Banking, or Wallet you will receive refund into the source account within 7-10 days from the time of order cancellation.\n"
              "If you still have any query about our Returns & Exchange policy kindly drop us an email at (website email id), we will reply you within 1-2 working days.\n\n"
              "Delivery Policy\n"
              "We usually take 5-6 working days for delivery from the date you place the order. Please note this delivery timeline is for ready available items and urban place only. We use our Courier partners for deliver the products .if you want more details about delivery you can mail us with your order with the information shared with via email when you placed your order.\n",
              textAlign: TextAlign.justify,
            ),
          ),
        ));
  }
}
