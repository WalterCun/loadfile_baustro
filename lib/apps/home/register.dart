import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      late Config conf;
      late int id;

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
      floatActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          log('Save Informations');
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.of(context).pushNamed(GenerateShopScreen.name);
          }
        },
      ),
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
                          controller: browser,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0.5.w,
                      ),
                      ElevatedButton(
                        style: InputThemes.elevatedButtonTheme,
                        child: Text(
                            AppLocalizations.of(context)!.button_openFileChoose),
                        onPressed: () {
                          openExplorer().then((path) {
                            if (path != null) {
                              browser.text = path;
                              openStore().then((store) {
                                late Config conf;
                                late int id;

                                final box = store.box<Config>();

                                final verification = box
                                    .query(
                                    Config_.parameter.contains('path_browser'))
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
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
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
