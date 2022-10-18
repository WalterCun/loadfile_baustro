import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/screens/base_screen.dart';
import '../../core/structs/paths.dart' show gifEsperando;
import '../../core/themes/fonts.dart';
import '../../core/themes/input_theme.dart';
import '../../core/utils/util.dart';

class GenerateShopScreen extends StatefulWidget {
  static const String name = 'generate_shop/';
  const GenerateShopScreen({Key? key}) : super(key: key);

  @override
  State<GenerateShopScreen> createState() => _GenerateShopScreenState();
}

class _GenerateShopScreenState extends State<GenerateShopScreen> {
  int currentPageIndex = 0;
  TextEditingController img = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      expanded: true,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.store),
            label: 'Bitmaps',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Configurations',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Templates',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Publicised',
          ),
        ],
      ),
      floatActionButton: FloatingActionButton(
        tooltip: 'Guardar Cambios',
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
      child: <Widget>[
        _pageBitsmaps(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Configurations'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Templates'),
        ),
        Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child: const Text('Publicised'),
        ),
      ][currentPageIndex],
    );
  }

  Widget _pageBitsmaps() {
    // Container(
    //   color: Colors.red,
    //   alignment: Alignment.center,
    //   child: const Text('Bitmaps'),
    // );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            AppLocalizations.of(context)!.form_fieldForm_chooseBrowser,
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
                onSaved: (String? path){

                },
              ),
            ),
            SizedBox(
              width: 0.5.w,
            ),
            ElevatedButton(
              style: InputThemes.elevatedButtonTheme,
              child: Text(AppLocalizations.of(context)!.button_openFileChoose),
              onPressed: () {
                openFileExplorer(
                  type: FileType.custom,
                  allowedExtensions: ['bmp'],
                ).then((List<String?>? paths) {
                  if (paths != null) {
                    setState(() {
                      img.text = paths[0]!;
                    });
                    log('$paths');
                  }
                });
              },
            )
          ],
        ),
        img.text.isEmpty
            ? Expanded(child: Image.asset(gifEsperando.path))
            : Image.asset(
                img.text,
                height: 400,
                width: 400,
              ),
      ],
    );
  }
}
