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
          
          disabledColor: Colors.black,
          showCheckmark: true,
          checkmarkColor: Colors.white,
          selectedColor: buttonColor,
          backgroundColor: Colors.grey[600],
          label: Text(
            option,
            style: TextStyle(color: Colors.white),
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
