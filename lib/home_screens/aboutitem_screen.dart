import 'package:flutter/material.dart';
class AboutItem extends StatefulWidget {
  const AboutItem({super.key});

  @override
  State<AboutItem> createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
                                   
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        'DESCRIPTION',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Specifications of Graphic Printed Cotton Half Sleeves Round Neck T-Shirt',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'A graphic printed t-shirt is a type of casual shirt that features a unique design, image, or text printed on the front. These shirts are typically made of soft and comfortable materials such as a cotton blend, which allows for easy movement and breathability. These shirts are popular among all age groups and genders and can be worn in a variety of settings, including casual outings. Graphic printed t-shirts are a fun and expressive way to showcase your personality and style.',
                                        textAlign: TextAlign.justify,
                                      ),
                                       Text(
                                        'A graphic printed t-shirt is a type of casual shirt that features a unique design, image, or text printed on the front. These shirts are typically made of soft and comfortable materials such as a cotton blend, which allows for easy movement and breathability. These shirts are popular among all age groups and genders and can be worn in a variety of settings, including casual outings. Graphic printed t-shirts are a fun and expressive way to showcase your personality and style.',
                                        textAlign: TextAlign.justify,
                                      ),
                                       Text(
                                        'A graphic printed t-shirt is a type of casual shirt that features a unique design, image, or text printed on the front. These shirts are typically made of soft and comfortable materials such as a cotton blend, which allows for easy movement and breathability. These shirts are popular among all age groups and genders and can be worn in a variety of settings, including casual outings. Graphic printed t-shirts are a fun and expressive way to showcase your personality and style.',
                                        textAlign: TextAlign.justify,
                                      )
                                    ],
                                  )),
    );
  }
}