import 'dart:developer';
import 'dart:io';

Future<bool> createFile(
    {required String pathFilename, bool recursive = true}) async {
  try {
    final file = await File(pathFilename).create(recursive: recursive);
    log(file.path);
  } on Exception catch (_) {
    return false;
  }

  return true;
}

Future<bool> writeFile(
    {required String pathFilename, required String content}) async {
  try {
    await File(pathFilename).writeAsString(content);
  } on Exception catch (_) {
    return false;
  }

  return true;
}
