import 'package:flutter/foundation.dart';

class DataProvider {
  static final DataProvider _singlenton = DataProvider._internal();
  factory DataProvider() => _singlenton;
  DataProvider._internal();

  String? nameShop;
  String? pathOutput;

  List<String> listAdvertising= [];
}
