import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/select_status_model.dart' as StatusModel;
import 'package:ezye/profilescreens/select_address.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final List<String> _states = [];
  List<String> _filterStates = [];
  TextEditingController searchController = TextEditingController();
  final TextEditingController _ad1 = TextEditingController();
  final TextEditingController _ad2 = TextEditingController();
  final TextEditingController _ad3 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  String locCountry = "";
  String locState = "";
  String locCity = "";
  String manualAddress = "";
  ShippingType shippingType = ShippingType.home;
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
  Future<void> _submitForm() async {
    if (_ad1.text.isEmpty || _ad2.text.isEmpty || _ad3.text.isEmpty) {
      setState(() {
        focusedColor = Colors.red;
        enabledColor = Colors.red;
      });
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_city.text.isEmpty ||
          _ad1.text.isEmpty ||
          _ad2.text.isEmpty ||
          _ad3.text.isEmpty ||
          _pincode.text.isEmpty ||
          _state.text.isEmpty) {
        return;
      }
      _showMyDialog();
      await addAddress();
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SelectAddress()));
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: _submitForm,
              child: const Text(
                'Save Address',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )),
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
                Row(
                  children: [
                    Radio<ShippingType>(
                      value: ShippingType.home,
                      groupValue: shippingType,
                      onChanged: (ShippingType? value) {
                        setState(() {
                          shippingType = value!;
                        });
                      },
                    ),
                    const Text('Home'),
                    Radio<ShippingType>(
                      value: ShippingType.work,
                      groupValue: shippingType,
                      onChanged: (ShippingType? value) {
                        setState(() {
                          shippingType = value!;
                        });
                      },
                    ),
                    const Text('Work'),
                    Radio<ShippingType>(
                      value: ShippingType.others,
                      groupValue: shippingType,
                      onChanged: (ShippingType? value) {
                        setState(() {
                          shippingType = value!;
                        });
                      },
                    ),
                    const Text('Others'),
                  ],
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

  Future<bool> addAddress() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.url}addAddress.php'),
        body: {
          'userId': FirebaseUser.user?.uid,
          'line1': _ad1.text,
          'line2': _ad2.text,
          'city': _city.text,
          'pincode': _pincode.text,
          'type': shippingType.name,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 5,
              ),
              Text('Processing....')
            ],
          ),
        );
      },
    );
  }
}

enum ShippingType { home, work, others }
