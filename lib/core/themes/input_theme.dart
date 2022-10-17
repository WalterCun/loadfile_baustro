import 'package:flutter/material.dart';

class InputThemes {
  static final elevatedButtonTheme = ElevatedButton.styleFrom(
    minimumSize: Size(100, 60),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );
}
