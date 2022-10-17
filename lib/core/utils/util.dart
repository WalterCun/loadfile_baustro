import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

Future<String?> openExplorer() async {
  String? _directoryPath;

  try {
    String? path = await FilePicker.platform.getDirectoryPath();
    _directoryPath = path;
  } on PlatformException catch (e) {
    log('$e');
  } catch (e) {
    log('$e');
  }

  return _directoryPath;
}
