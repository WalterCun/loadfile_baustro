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

Future<int> readFile({required String pathFilename}) async {
  final contents;

  try {
    contents = await File(pathFilename).readAsString();
  } catch (e) {
    // Si encuentras un error, regresamos 0
    return 0;
  }
  return int.parse(contents);
}

// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/counter.txt');
// }

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//
//   return directory.path;
// }

Future<File> transfer(sourceFile,
    {required String to, bool deleteOrigin = true}) async {
  try {
    /// prefer using rename as it is probably faster
    /// if same directory path
    return await sourceFile.rename(to);
  } catch (e) {
    /// if rename fails, copy the source file
    final newFile = await sourceFile.copy(to);
    if (deleteOrigin) _delete(path: sourceFile.path);
    return newFile;
  }
}

Future<bool> _delete({required String path}) async {
  if (await Directory(path).exists()) {
    return true;
  }
  if (await File(path).exists()) {}

  return false;
  // path!.deleteSync(recursive: true);
}
