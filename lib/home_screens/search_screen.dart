import 'package:ezys/custom_widgets/constants.dart';
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
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: buttonColor,
        ),
        centerTitle: true,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
              fillColor: bgcolor,
              filled: true,
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(
                  'assets/icons/Search.svg',
                  height: 23,
                  width: 23,
                  color: Colors.grey[800],
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 28, minWidth: 28),
              hintText: 'Search Your Favorite...',
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
        ),
      ),
    );
  }
}
