import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

import '../../../conf/settings.dart';
import '../../../core/db/manager.dart';
import '../../../core/screens/base_screen.dart';
import '../../../core/inputformatters/inputsfomatters.dart';
import '../../../core/structs/paths.dart' show gifEsperando;
import '../../../core/themes/fonts.dart';
import '../../../core/themes/input_theme.dart';
import '../../../core/utils/util.dart';
import '../widgets/custom_widget.dart';
import '../widgets/tree_buttons_widgets.dart';

class GenerateShopScreen extends StatefulWidget {
  static const String name = 'generate_shop/';
  const GenerateShopScreen({Key? key}) : super(key: key);

  @override
  State<GenerateShopScreen> createState() => _GenerateShopScreenState();
}

class _GenerateShopScreenState extends State<GenerateShopScreen> {
  final data = DataProvider();
  int currentPageIndex = 0;

  TextEditingController img = TextEditingController(text: '');
  final _formKeyShop = GlobalKey<FormState>();
  // final _formKeyParametersShop = GlobalKey<FormState>();

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
        heroTag: 'btnContruir',
        tooltip: 'CONTRUIR CARPETA',
        backgroundColor: Colors.blue,
        hoverColor: Colors.green,
        onPressed: () {
          if (_formKeyShop.currentState!.validate()) {
            _formKeyShop.currentState!.save();
            print(data);
          }
        },
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
                onSaved: (String? path) {
                  if (path != null || path!.isNotEmpty) {
                    data.pathLogo = path;
                  }
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
    return Form(
      key: _formKeyShop,
      child: Column(
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
                            initialValue: data.nameShop,
                            decoration: const InputDecoration(
                              label: Text('NOMBRE DEL COMERCIO'),
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                              LengthLimitingTextInputFormatter(limitLengthShop),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Z ]+'))
                            ],
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
                                  validator: (String? codigoComercio) =>
                                      (codigoComercio == null ||
                                              codigoComercio.isEmpty)
                                          ? 'EL CAMPO ES OBLIGATORIO'
                                          : null,
                                  onSaved: (String? codigoComercio) {
                                    if (codigoComercio != null ||
                                        codigoComercio!.isNotEmpty) {
                                      data.codeShop = codigoComercio;
                                    }
                                  },
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
                                  validator: (String? seriePOS) =>
                                  (seriePOS == null || seriePOS.isEmpty)
                                      ? 'EL CAMPO ES OBLIGATORIO'
                                      : null,
                                  onSaved: (String? seriePos) {
                                    if (seriePos != null ||
                                        seriePos!.isNotEmpty) {
                                      data.serie = seriePos;
                                    }
                                  },
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
                  tiles: [
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
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                              LengthLimitingTextInputFormatter(
                                  limitLengthDirectionShop),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Z ]+'))
                            ],
                            validator: (String? direccion) =>
                                (direccion == null || direccion.isEmpty)
                                    ? 'EL CAMPO ES OBLIGATORIO'
                                    : null,
                            onSaved: (String? direction) {
                              if (direction != null || direction!.isNotEmpty) {
                                data.direction = direction;
                              }
                            },
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
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(
                                        limitLengthPhoneShop),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (String? phone) =>
                                      (phone == null || phone.isEmpty)
                                          ? 'EL CAMPO ES OBLIGATORIO'
                                          : null,
                                  onSaved: (String? phone) {
                                    if (phone != null || phone!.isNotEmpty) {
                                      data.phone = phone;
                                    }
                                  },
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
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(
                                        limitLengthPhoneShop),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[A-Z ]+'))
                                  ],
                                  validator: (String? ciudad) {
                                    if (ciudad == null || ciudad.isEmpty) {
                                      return 'CAMPO OBLIGATORIO';
                                    }

                                    return null;
                                  },
                                  onSaved: (String? ciudad) {
                                    if (ciudad != null || ciudad!.isNotEmpty) {
                                      data.city = ciudad;
                                    }
                                  },
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
                                    UpperCaseTextFormatter(),
                                    LengthLimitingTextInputFormatter(
                                        limitLengthRucShop),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (String? ruc) =>
                                      validateCedula(ruc)['message'],
                                  onSaved: (String? ruc) {},
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
                  tiles: [
                    CustomTile(
                        child: SwitchCustomTile(
                      title: 'IVA',
                      children: [
                        Center(
                            child: ThreeButtonToggle(
                          oneText: '0%',
                          twoText: '12%',
                          threeText: '18%',
                          change: (int index) {
                            log('$index');
                          },
                        ))
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
                    CustomTile(
                        child: SwitchCustomTile(
                      title: 'INTERES',
                      children: [
                        Text('Sorpresa'),
                      ],
                    )),
                    CustomTile(
                        child: SwitchCustomTile(
                      title: 'MONTO FIJO',
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
      ),
    );
  }

  Widget _pageTemplates() {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: const Text('Templates'),
    );
  }

  Widget _pagePublished() {
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      child: const Text('Marketing'),
    );
  }
}
