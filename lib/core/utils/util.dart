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

Map<String, dynamic> validateCedula(String? cedula) {
  Map<String, dynamic> resp = {
    'validate': false,
    'message': null,
    'data': {}
  };

  if (cedula == null || cedula.isEmpty){
    resp['message'] = 'EL CAMPO ES OBLIGATORIO';
    return resp;
  }

  if (cedula.length == 13) {
    resp.addAll({'data':{
      'ruc': true,
      'type': int.parse(cedula.substring(12, 13)) >= 0 &&
          int.parse(cedula.substring(12, 13)) <= 5
          ? "NATURAL"
          : int.parse(cedula.substring(12, 13)) == 6
          ? 'SOCIEDAD PUBLICA'
          : int.parse(cedula.substring(12, 13)) == 9
          ? 'SOCIEDAD PRIVADA'
          : 'NO DEFINIDO'
    }});

    cedula = cedula.substring(0, 10);
  }

  /// Funcion de validacion de cedula ecuatoriana
  int suma = 0, mul = 2, chars = cedula.length;

  if (cedula.isEmpty) {
    resp['message'] = 'ES NECESARIO LLENAR ESTE CAMPO';
    return resp;
  }

  if (cedula.length != 10) {
    resp['message'] = 'LA CÉDULA DEBE TENER 10 DÍGITOS';
    return resp;
  }

  if (int.tryParse(cedula) == null) {
    resp['message'] = 'EL VALOR INGRESADO NO CORRESPONDE A UN NÚMERO';
    return resp;
  }

  resp['data'].addAll({'provincia': cedula.substring(0, 2)});

  int _prov = int.parse(resp['data']['provincia']);
  if (_prov > 24 && _prov != 30) {
    resp['message'] = 'LA CÉDULA INGRESADA NO ES ECUATORIANA';
  } else {
    for (int index = 0; index < chars; index += 1) {
      int valor = int.parse(cedula[index]) * mul;
      suma += valor > 9 ? valor - 9 : valor;
      mul = (index % 2) == 0 ? 1 : 2;
    }
    if (suma % 10 == 0 && suma > 0) {
      resp['validate'] = true;
      resp['message'] = null;
    } else {
      resp['message'] = 'CÉDULA INGRESADA NO ES VALIDA';
    }
  }

  return resp;
}
