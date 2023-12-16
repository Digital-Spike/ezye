import 'package:ezye/home_screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(
                  'assets/svg/searching.svg',
                  height: 23,
                  width: 23,
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 28, minWidth: 28),
              hintStyle:
                  const TextStyle(fontSize: 14, color: Color(0xffBDC1CA)),
              hintText: 'Search product, category, etc',
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(width: 1.5, color: Color(0xffE8E9EE))),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(width: 1.5, color: Color(0xffE8E9EE))),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide:
                      BorderSide(width: 1.5, color: Color(0xffE8E9EE)))),
          onSubmitted: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductList(searchText: value)));
          },
        ),
      ),
    );
  }
}
