import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/home_screens/grid_items.dart';
import 'package:ezye/model/home_list.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatefulWidget {
  final HomeList homeList;

  const HomeListView({super.key, required this.homeList});

  @override
  State<StatefulWidget> createState() => HomeListViewState();
}

class HomeListViewState extends State<HomeListView> {
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
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: (homeList.items ?? []).length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                HomeItem homeItem = (homeList.items ?? [])[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GridItems(
                                  category: homeItem.category ?? '')));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 82,
                          width: 82,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ApiService.uploads}${homeItem.imageUrl}',
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
                        const SizedBox(height: 5),
                        Text(homeItem.category ?? '')
                      ],
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
