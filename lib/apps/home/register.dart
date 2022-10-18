import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/models/shops_model.dart';
import '../../objectbox.g.dart';

import '../home/shops.dart';
import '../../core/screens/base_screen.dart';
import '../../core/models/config_model.dart';
import '../../core/themes/fonts.dart';
import '../../core/themes/input_theme.dart';
import '../../core/utils/util.dart';
import '../../core/structs/paths.dart' show gifTrabajando;

class RegisterScreen extends StatefulWidget {
  static const String name = 'register/';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController browser = TextEditingController(text: '');
  TextEditingController shop = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // Cargar los valores del directorio de carga de archivos
    openStore().then((store) {
      final box = store.box<Config>();

      final verification =
          box.query(Config_.parameter.contains('path_browser')).build().find();

      if (verification.length > 0) {
        browser.text = verification.last.value!;
      }

      store.close();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      padding: const EdgeInsets.all(15),
      expanded: false,
      // floatActionButton: ,
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
                      AppLocalizations.of(context)!
                          .form_fieldForm_chooseBrowser,
                      style: blackStyle.copyWith(fontSize: 8.sp),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: browser,
                          style: TextStyle(),
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
                        ),
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      ElevatedButton(
                        style: InputThemes.elevatedButtonTheme,
                        child: Text(AppLocalizations.of(context)!
                            .button_openFileChoose),
                        onPressed: () {
                          openExplorer().then((path) {
                            if (path != null) {
                              browser.text = path;
                              openStore().then((store) {
                                late Config conf;
                                late int id;

                                final box = store.box<Config>();

                                final verification = box
                                    .query(Config_.parameter
                                        .contains('path_browser'))
                                    .build()
                                    .find();

                                if (!(verification.length > 0)) {
                                  conf = Config(
                                      parameter: 'path_browser', value: path);
                                  id = box.put(conf);
                                  log('New create row: $id');
                                } else {
                                  conf = verification.last;
                                  conf.value = path;
                                }

                                id = box.put(conf);
                                log('Replace row: $id');

                                store.close();
                              });
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
                      AppLocalizations.of(context)!.form_fieldForm_nameShops,
                      style: blackStyle.copyWith(fontSize: 8.sp),
                    ),
                  ),
                  TextFormField(
                    controller: shop,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? path) {
                      log('El nombre del comercio: $path');
                      if (path == null || path.isEmpty) {
                        return 'EL CAMPO NO PUEDE ESTAR VACIO';
                      }
                      return null;
                    },
                    onSaved: (String? shop) async {
                      late Shop shops;
                      late int id;
                      final store = await openStore();
                      final box = store.box<Shop>();

                      shops = Shop();
                      id = box.put(shops);
                      log('New shops create id: $id');

                      store.close();
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
