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

Future<List<String?>?> openFileExplorer(
    {FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool multipleFiles = false}) async {
  List<String?>? filePath;

  try {
    /*
    * {
    *   String? dialogTitle,
    *   String? initialDirectory,
    *   FileType type = FileType.any,
    *   List<String>? allowedExtensions,
    *   dynamic Function(FilePickerStatus)? onFileLoading,
    *   bool allowCompression = true,
    *   bool allowMultiple = false,
    *   bool withData = false,
    *   bool withReadStream = false,
    *   bool lockParentWindow = false, }
    * */
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: multipleFiles);

    if (result == null) {
      log('Cancelar captura');
      return null;
    }

    if (multipleFiles) {
      log('Multiples Files');
      filePath = [...result.paths];
    }

    if (!multipleFiles) {
      log('Unico Archivo');
      filePath = [result.files.single.path];
    }
  } on PlatformException catch (e) {
    log('$e');
  } catch (e) {
    log('$e');
  }

  log('$filePath');
  return filePath;
}
