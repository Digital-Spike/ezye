import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/select_status_model.dart' as StatusModel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  List<String> _states = [];
  List<String> _filterStates = [];
  TextEditingController searchController = TextEditingController();
  var _ad1 = new TextEditingController();
  var _ad2 = new TextEditingController();
  var _ad3 = new TextEditingController();
  var _city = new TextEditingController();
  var _state = new TextEditingController();
  var _pincode = new TextEditingController();
  String locCountry = "";
  String locState = "";
  String locCity = "";
  String manualAddress = "";
  Color enabledColor = const Color(0xffE8E9EE);
  Color focusedColor = const Color(0xff7C7D85);
  final errorBorder = const BorderSide(
    width: 1.5,
    color: Colors.red,
  );
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

  final _formKey = GlobalKey<FormState>();
  void _submitForm() {
    if (_ad1.text.isEmpty || _ad2.text.isEmpty || _ad3.text.isEmpty) {
      setState(() {
        focusedColor = Colors.red;
        enabledColor = Colors.red;
        print("Hello");
      });
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_city.text.isEmpty &&
          _ad1.text.isEmpty &&
          _ad2.text.isEmpty &&
          _ad3.text.isEmpty &&
          _pincode.text.isEmpty &&
          _state.text.isEmpty) {
        return;
      }
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Address',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side:
                            const BorderSide(width: 1.5, color: Colors.black)),
                    onPressed: () {
                      setState(() {
                        _ad1.clear();
                        _ad2.clear();
                        _ad3.clear();
                        _city.clear();
                        _state.clear();
                        _pincode.clear();
                      });
                    },
                    child: const Text(
                      'Undo Changes',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: _submitForm,
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Address',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _ad1,
                  decoration: InputDecoration(
                    hintText: 'Address line 1',
                    hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: focusedColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: enabledColor)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ad2,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintText: 'Address line 2',
                    hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: focusedColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: enabledColor),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ad3,
                  decoration: InputDecoration(
                    hintText: 'Address line 3',
                    hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: focusedColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: enabledColor)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter complete address';
                    } else {
                      return null;
                    }
                  },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      color: Colors.white),
                  controller: _city,
                  searchInputDecoration: InputDecoration(
                      isDense: true,
                      hintText: 'Select city',
                      hintStyle: const TextStyle(
                        color: Color(0xff7C7D85),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                  suggestions:
                      _states.map((e) => SearchFieldListItem(e)).toList(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your city';
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      color: Colors.white),
                  controller: _state,
                  searchInputDecoration: InputDecoration(
                      isDense: true,
                      hintText: 'Select state',
                      hintStyle: const TextStyle(
                        color: Color(0xff7C7D85),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                  suggestions:
                      _states.map((e) => SearchFieldListItem(e)).toList(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your state';
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
                  controller: _pincode,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Enter pincode',
                    hintStyle: const TextStyle(color: Color(0xff7C7D85)),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 1.5, color: Color(0xff7C7D85))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xffE8E9EE))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
