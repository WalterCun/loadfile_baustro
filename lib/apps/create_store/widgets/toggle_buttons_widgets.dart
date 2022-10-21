import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:format/format.dart';

// recurso: https://blog.logrocket.com/advanced-guide-flutter-switches-toggles/
class GeneratedButtonToggle extends StatefulWidget {
  // final String oneText, twoText, threeText;
  final List<String> bottoms;
  final int? defaultIndex;
  // final String? oneText, twoText, threeText;
  final Function(int index) change;

  const GeneratedButtonToggle(
      {Key? key,
      required this.bottoms,
      this.defaultIndex,
      required this.change})
      : super(key: key);

  // ThreeButtonToggle.two(this.oneText, this.twoText, this.threeText);

  @override
  State<GeneratedButtonToggle> createState() => _GeneratedButtonToggleState();
}

class _GeneratedButtonToggleState extends State<GeneratedButtonToggle> {
  List<bool> isSelected = [];
  int longText = 0;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    if (!load) {
      isSelected.clear();
      widget.bottoms.forEach((element) {
        longText = element.length > longText ? element.length : longText;
      });

      if (widget.defaultIndex == null) {
        isSelected = widget.bottoms.map((e) => false).toList();
      } else {
        for (var i = 0; i <= widget.bottoms.length - 1; i++) {
          if (i == widget.defaultIndex) {
            isSelected.add(true);
          } else {
            isSelected.add(false);
          }
          log('i: $i / ${widget.defaultIndex}');
        }
      }
      load = true;
    }

    return ToggleButtons(
        // list of booleans
        isSelected: isSelected,
        // text color of selected toggle
        selectedColor: Colors.white,
        // text color of not selected toggle
        color: Colors.blue,
        // fill color of selected toggle
        fillColor: Colors.lightBlue.shade900,
        // when pressed, splash color is seen
        splashColor: Colors.red,
        // long press to identify highlight color
        highlightColor: Colors.orange,
        // if consistency is needed for all text style
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        // border properties for each toggle
        renderBorder: true,
        borderColor: Colors.black,
        borderWidth: 1.2,
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Colors.blue,
// add widgets for which the users need to toggle
        children: widget.bottoms
            .map((texto) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('{text:^$longText}'.format({#text: texto}),
                      style: const TextStyle(fontSize: 12)),
                ))
            .toList(),
        // to select or deselect when pressed
        onPressed: (int newIndex) {
          widget.change(newIndex);
          setState(() {
            // looping through the list of booleans values
            for (int index = 0; index < isSelected.length; index++) {
              // checking for the index value
              if (index == newIndex) {
                // one button is always set to true
                isSelected[index] = true;
              } else {
                // other two will be set to false and not selected
                isSelected[index] = false;
              }
            }
          });
        });
  }
}
