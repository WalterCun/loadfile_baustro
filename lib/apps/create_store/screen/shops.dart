import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/screens/base_screen.dart';
import '../../../core/structs/paths.dart' show gifEsperando;
import '../../../core/themes/fonts.dart';
import '../../../core/themes/input_theme.dart';
import '../../../core/utils/util.dart';
import '../../widgets/custom_widget.dart';

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
            selectedIcon: Icon(Icons.check),
            label: 'Bitmaps',
          ),
          NavigationDestination(
            icon: Icon(Icons.handyman),
            selectedIcon: Icon(Icons.check),
            label: 'Configurations',
          ),
          NavigationDestination(
            icon: Icon(Icons.web),
            selectedIcon: Icon(Icons.check),
            label: 'Templates',
          ),
          NavigationDestination(
            icon: Icon(Icons.publish),
            selectedIcon: Icon(Icons.check),
            label: 'Publicised',
          ),
        ],
      ),
      floatActionButton: FloatingActionButton(
        heroTag: 'btn',
        tooltip: 'Guardar Cambios',
        backgroundColor: Colors.blue,
        hoverColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.build),
      ),
      child: <Widget>[
        _pageBitsmaps(),
        _pageConfigurations(),
        _pageTemplates(),
        _pagePublished(),
      ][currentPageIndex],
    );
  }

  Widget _pageBitsmaps() {
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
                onSaved: (String? path) {},
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
            : Expanded(
                child: Image.file(File(img.text)),
              ),
      ],
    );
  }

  Widget _pageConfigurations() {
    return Column(
      children: [
        Expanded(
          child: SettingsList(
            shrinkWrap: true,
            sections: [
              SettingsSection(
                titleWidget: Text(
                  'DATOS DEL COMERCIO',
                  style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                tiles: [
                  CustomTile(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          initialValue: '',
                          decoration: const InputDecoration(
                            label: Text('NOMBRE DEL COMERCIO'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('CODIGO DE COMERCIO'),
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (String? codigoComercio){return 'CAMPO OBLIGATORIO';},
                                onSaved: (String? codigoComercio){},
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('SERIE DE POS'),
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (String? codigoComercio){return 'CAMPO OBLIGATORIO';},
                                onSaved: (String? codigoComercio){},
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ],
              ),
              SettingsSection(
                title: 'PARAMETROS CLT HDR',
                tiles:  [
                  CustomTile(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('DIRECCION DEL COMERCIO'),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      label: Text('TELEFONO'),
                                      border: OutlineInputBorder(),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? codigoComercio){return 'CAMPO OBLIGATORIO';},
                                    onSaved: (String? codigoComercio){},
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    initialValue: 'CUENCA',
                                    decoration: const InputDecoration(
                                      label: Text('CUIDAD'),
                                      border: OutlineInputBorder(),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? codigoComercio){return 'CAMPO OBLIGATORIO';},
                                    onSaved: (String? codigoComercio){},
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      label: Text('RUC'),
                                      border: OutlineInputBorder(),
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String? codigoComercio){return 'CAMPO OBLIGATORIO';},
                                    onSaved: (String? codigoComercio){},
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ],
              ),
              SettingsSection(
                title: 'PARAMETROS CLT IAD',
                tiles: const [
                  CustomTile(
                      child: SwitchCustomTile(
                    title: 'MONTO FIJO',
                    children: [
                      Text('Sorpresa'),
                    ],
                  )),
                  CustomTile(
                      child: SwitchCustomTile(
                    title: 'INTERES',
                    children: [
                      Text('Sorpresa'),
                    ],
                  )),
                  CustomTile(
                      child: SwitchCustomTile(
                    title: 'PROPINA',
                    children: [
                      Text('Sorpresa'),
                    ],
                  )),
                  CustomTile(
                      child: SwitchCustomTile(
                    title: 'SERVICIO',
                    children: [
                      Text('Sorpresa'),
                    ],
                  )),
                ],
              ),
              CustomSection(
                  child: const CustomTile(
                      child: SizedBox(
                height: 25,
              )))
            ],
          ),
        )
      ],
    );
  }

  Widget _pageTemplates() {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text('Templates'),
    );
  }

  _pagePublished() {
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      child: const Text('Marketing'),
    );
  }
}
