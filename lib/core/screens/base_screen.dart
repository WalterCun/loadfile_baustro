// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

class BaseScreen extends StatelessWidget {

  final Widget child;
  bool paddingOff;

  BaseScreen({Key? key,
    required this.child,
    this.paddingOff = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: Color(0xFF805306),
        child: child,
      ),
    );
  }
}
