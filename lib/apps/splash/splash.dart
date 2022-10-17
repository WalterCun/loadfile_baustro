import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'package:loadfile_baustro/core/screens/base_screen.dart';
import 'package:loadfile_baustro/core/structs/paths.dart';

class SplashScreen extends StatefulWidget {
  static String name = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(milliseconds: 2350),
    //         () => Navigator.pushReplacementNamed(context, 'home_page'));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Column(children: [
      Image.asset(
        imgLogo.path,
        width: 100.w,
      )
    ]));
  }
}
