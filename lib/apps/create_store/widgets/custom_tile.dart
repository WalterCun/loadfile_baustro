import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/fonts.dart';
import 'toggle_buttons_widgets.dart';

class ToggleButtomTile extends StatefulWidget {
  // final String oneText, twoText, threeText;
  final String title;
  final List<String> bottoms;
  final int? defaultIndex;
  // final String? oneText, twoText, threeText;
  final Function(int index) change;

  const ToggleButtomTile(
      {Key? key,
      required this.title,
      required this.bottoms,
      this.defaultIndex,
      required this.change})
      : super(key: key);

  @override
  State<ToggleButtomTile> createState() => _ToggleButtomTileState();
}

class _ToggleButtomTileState extends State<ToggleButtomTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              widget.title,
              style: blackStyle.copyWith(
                  fontSize: 6.sp, fontWeight: FontWeight.w600),
            ),
          ),
          GeneratedButtonToggle(
            bottoms: widget.bottoms,
            defaultIndex: widget.defaultIndex,
            change: (int index) {
              widget.change(index);
            },
          ),
        ],
      ),
    );
  }
}
