import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/db/manager.dart';
import '../../../core/structs/paths.dart';
import '../../../core/themes/fonts.dart';
import '../../../core/themes/input_theme.dart';
import '../../../core/utils/util.dart';

class BitmapsPage extends StatefulWidget {
  const BitmapsPage({Key? key}) : super(key: key);

  @override
  State<BitmapsPage> createState() => _BitmapsPageState();
}

class _BitmapsPageState extends State<BitmapsPage> {
  final data = DataProvider();
  TextEditingController img = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    img.text = data.pathLogo!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'IMAGEN DEL COMERCIO (.BMP)',
            style: blackStyle.copyWith(fontSize: 8.sp),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                controller: img,
                style: const TextStyle(), //TODO: Agregar Style
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (String? path) {
                  log('Ruta de imagen para comercio: $path');
                  if (path == null || path.isEmpty) {
                    return 'EL CAMPO NO PUEDE ESTAR VACIO';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 0.5.w,
            ),
            ElevatedButton(
              style: InputThemes.elevatedButtonTheme,
              child: const Text('ELEGIR UNA IMAGEN'),
              onPressed: () {
                openFileExplorer(
                  type: FileType.custom,
                  allowedExtensions: ['bmp'],
                ).then((List<String?>? paths) {
                  if (paths != null) {
                    setState(() {
                      img.text = paths[0]!;
                      data.pathLogo = paths[0];
                      log('Saved: ${paths[0]}', name: 'data.pathLogo');
                    });
                  }
                });
              },
            )
          ],
        ),
        img.text.isEmpty
            ? Expanded(child: Image.asset(gifEsperando.path))
            : Expanded(
                child: Image.file(File(img.text)),
              ),
      ],
    );
  }
}
