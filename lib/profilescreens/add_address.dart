import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/select_status_model.dart' as StatusModel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

class AddAdress extends StatefulWidget {
  const AddAdress({super.key});

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  List<String> _states = [];
  List<String> _filterStates = [];
  TextEditingController searchController = TextEditingController();
  var _city = new TextEditingController();
  var _state = new TextEditingController();
  String locCountry = "";
  String locState = "";
  String locCity = "";
  String manualAddress = "";
  Future getResponse() async {
    var res = await rootBundle.loadString('assets/json/country.json');
    return jsonDecode(res);
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == "India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var state in states) {
      if (!mounted) continue;
      var name = state.map((item) {
        for (var city in item.city) {
          _states.add(city.name.toString());
        }
        return item.name;
      }).toList();
      for (var stateName in name) {
        _states.add(stateName.toString());
      }
      _states.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      _filterStates = _states;
    }

    setState(() {});
    return _states;
  }

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Address',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Address line 1',
                hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Color(0xff7C7D85))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffE8E9EE))),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Address line 2',
                hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Color(0xff7C7D85))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffE8E9EE))),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Address line 3',
                hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Color(0xff7C7D85))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffE8E9EE))),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'City',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            SearchField(
              suggestionsDecoration: SuggestionDecoration(
                  borderRadius: BorderRadius.circular(15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: Border.all(width: 0.5, color: Colors.grey),
                  color: Colors.white),
              controller: _city,
              searchInputDecoration: InputDecoration(
                  isDense: true,
                  hintText: 'Select city',
                  hintStyle: const TextStyle(
                    color: Color(0xff7C7D85),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffE8E9EE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xff7C7D85),
                        width: 1.5,
                      ))),
              // ignore: prefer_const_literals_to_create_immutables
              suggestions: _states.map((e) => SearchFieldListItem(e)).toList(),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your City';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'State',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            SearchField(
              suggestionsDecoration: SuggestionDecoration(
                  borderRadius: BorderRadius.circular(15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: Border.all(width: 0.5, color: Colors.grey),
                  color: Colors.white),
              controller: _state,
              searchInputDecoration: InputDecoration(
                  isDense: true,
                  hintText: 'Select state',
                  hintStyle: const TextStyle(
                    color: Color(0xff7C7D85),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xffE8E9EE),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xff7C7D85),
                        width: 1.5,
                      ))),
              // ignore: prefer_const_literals_to_create_immutables
              suggestions: _states.map((e) => SearchFieldListItem(e)).toList(),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your City';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'Pincode',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(6)],
              decoration: InputDecoration(
                hintText: 'Enter pincode',
                hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Color(0xff7C7D85))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffE8E9EE))),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: const Text(
                  'Save Address',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
