import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';

class MultiSelectChoiceChips extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChoiceChips(
      {required this.options, required this.onSelectionChanged});

  @override
  _MultiSelectChoiceChipsState createState() => _MultiSelectChoiceChipsState();
}

class _MultiSelectChoiceChipsState extends State<MultiSelectChoiceChips> {
  List<String> selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
      widget.onSelectionChanged(selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: widget.options.map((option) {
        return ChoiceChip(
          side: BorderSide(width: 0.5),
          disabledColor: Colors.black,
          /*showCheckmark: true,
          checkmarkColor: Colors.white,*/
          selectedColor: buttonColor,
          backgroundColor: Colors.white,
          label: Text(
            option,
            style: TextStyle(
              color: selectedOptions.contains(option)
                  ? Colors.white // Change text color when selected
                  : Colors.black, // Change text color when not selected
            ),
          ),
          selected: selectedOptions.contains(option),
          onSelected: (_) {
            _toggleOption(option);
          },
        );
      }).toList(),
    );
  }
}
