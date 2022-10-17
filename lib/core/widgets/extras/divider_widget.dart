import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  final double? thickness;

  const CustomDivider(
      {Key? key,
        this.height,
        this.color,
        this.thickness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1,
      color: color ?? Colors.grey,
      thickness: thickness ?? 1,
    );
  }
}
