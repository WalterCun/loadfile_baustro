import 'package:flutter/material.dart';


class IconMenuFloatButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Function()? onPressed;
  final String? tooltip;

  IconMenuFloatButton(
      {Key? key, required this.icon, this.iconSize, this.onPressed, this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 50,
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        tooltip: tooltip,
        onPressed: onPressed);
  }
}
