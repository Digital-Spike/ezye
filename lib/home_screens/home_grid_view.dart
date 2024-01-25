import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/home_screens/product_screen.dart';
import 'package:ezye/model/home_list.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeGridView extends StatefulWidget {
  final HomeList homeList;

  const HomeGridView({super.key, required this.homeList});

  @override
  State<StatefulWidget> createState() => HomeGridViewState();
}

class HomeGridViewState extends State<HomeGridView> {
  late HomeList homeList;

  @override
  void initState() {
    homeList = widget.homeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                homeList.title ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: (homeList.items ?? []).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1 / 1.4,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                HomeItem homeItem = (homeList.items ?? [])[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductScreen(
                                  productId: homeItem.category ?? "",
                                )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: '${ApiService.uploads}${homeItem.imageUrl}',
                        placeholder: (context, url) => const CircleAvatar(
                          backgroundColor: Colors.white30,
                        ),
                        errorWidget: (context, url, error) => Padding(
                          padding: const EdgeInsets.all(0),
                          child: Image.asset('assets/png/woman.png',
                              fit: BoxFit.cover),
                        ),
                        imageBuilder: (context, image) =>
                            Image(image: image, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
