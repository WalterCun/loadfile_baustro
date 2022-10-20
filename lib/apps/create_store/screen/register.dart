import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';
import 'package:path/path.dart' show join;

import '../../../conf/settings.dart';
import '../../../core/db/manager.dart';
import '../../../core/screens/base_screen.dart';
import '../../../core/inputformatters/inputsfomatters.dart';
import '../../../core/themes/fonts.dart';
import '../../../core/themes/input_theme.dart';
import '../../../core/utils/util.dart';
import '../../../core/structs/paths.dart' show gifTrabajando;

import 'shops.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  static const String name = 'register/';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController browser =
      TextEditingController(text: join(Directory.current.path, 'comercios'));
  TextEditingController shop = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _floatActionBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'return Home',
          backgroundColor: Colors.red,
          hoverColor: Colors.orange,
          tooltip: 'CANCELAR',
          child: const Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.name);
          },
        ),
        SizedBox(
          height: 1.5.w,
        ),
        FloatingActionButton(
          heroTag: 'continueShops',
          backgroundColor: Colors.blue,
          hoverColor: Colors.green,
          tooltip: 'GUARDAR CAMBIOS',
          child: const Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pushNamed(GenerateShopScreen.name);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = DataProvider();

    return BaseScreen(
      padding: const EdgeInsets.all(15),
      expanded: false,
      floatActionButton: _floatActionBottom(),
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: 93.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'DIRECTORIO DE SALIDA',
                      style: blackStyle.copyWith(fontSize: 8.sp),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: browser,
                          style: const TextStyle(), //TODO: Agregar Style
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? path) {
                            log('Ruta de salida de comercios: $path');
                            if (path == null || path.isEmpty) {
                              return 'EL CAMPO NO PUEDE ESTAR VACIO';
                            }
                            return null;
                          },
                          onSaved: (String? path){
                            data.pathOutput = path;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      ElevatedButton(
                        style: InputThemes.elevatedButtonTheme,
                        child: Text('CAMBIAR DIRECTORIO'),
                        onPressed: () {
                          openExplorer().then((path) {
                            if (path != null) {
                              browser.text = path;
                              // data.pathOutput = path;
                            }
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'NOMBRE DEL COMERCIO',
                      style: blackStyle.copyWith(fontSize: 8.sp),
                    ),
                  ),
                  TextFormField(
                    controller: shop,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(limitLengthShop),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]+'))
                    ],
                    validator: (String? path) {
                      log('El nombre del comercio: $path');
                      if (path == null || path.isEmpty) {
                        return 'EL CAMPO NO PUEDE ESTAR VACIO';
                      }
                      return null;
                    },
                    onSaved: (String? shop) {
                      if( shop != null || shop!.isNotEmpty){
                        data.nameShop = shop;
                      }
                    },
                  ),
                ],
              ),
              Image.asset(gifTrabajando.path)
            ],
          ),
        ),
      ),
    );
  }
}
