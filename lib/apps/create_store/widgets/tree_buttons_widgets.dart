import 'package:flutter/material.dart';

// recurso: https://blog.logrocket.com/advanced-guide-flutter-switches-toggles/
class ThreeButtonToggle extends StatefulWidget {
  final String oneText, twoText, threeText;
  // final String? oneText, twoText, threeText;
  final Function(int index) change;

  const ThreeButtonToggle(
      {Key? key,
      required this.oneText,
      required this.twoText,
      required this.threeText,
        required this.change
      })
      : super(key: key);

  // ThreeButtonToggle.two(this.oneText, this.twoText, this.threeText);

  @override
  State<ThreeButtonToggle> createState() => _ThreeButtonToggleState();
}

class _ThreeButtonToggleState extends State<ThreeButtonToggle> {
  final List<bool> isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
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
        borderWidth: 1.0,
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Colors.blue,
// add widgets for which the users need to toggle
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Text(widget.oneText, style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Text(widget.twoText, style: TextStyle(fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Text(widget.threeText, style: TextStyle(fontSize: 18)),
          ),
        ],
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
