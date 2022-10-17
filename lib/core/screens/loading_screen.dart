import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'base_screen.dart';

class TempSplash extends StatefulWidget {
  final bool logo;
  final String icono;
  final String texto;

  const TempSplash(
      {Key? key, this.logo = true, required this.icono, required this.texto})
      : super(key: key);

  @override
  State<TempSplash> createState() => _TempSplashState();
}

class _TempSplashState extends State<TempSplash> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      // wrapInScroll: false,
      // baustroAppBar: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   imgAustroDigitalLogoAzul.path,
              //   width: 35.w,
              // ),
            ],
          ),
          const SizedBox(height: 110),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.icono,
                width: 33.w,
              )
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(widget.texto.toUpperCase(),
                      textAlign: TextAlign.center,
                      // style: heavyBlue.copyWith(fontSize: 16.sp)
          ))
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
