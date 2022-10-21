import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:sizer/sizer.dart';

import '../../../conf/settings.dart';
import '../../../core/db/manager.dart';
import '../../../core/inputformatters/inputsfomatters.dart';
import '../../../core/themes/fonts.dart';
import '../../../core/utils/util.dart';
import '../widgets/custom_tile.dart';
import '../widgets/custom_widget.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {

  final data = DataProvider();

  final _formKeyShop = GlobalKey<FormState>();
  TextEditingController ivaValue = TextEditingController(text: '');
  TextEditingController propinaValue = TextEditingController(text: '');
  TextEditingController servicioValue = TextEditingController(text: '');
  TextEditingController montofijoValue = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {

    ivaValue.text = '${data.iva.value}';
    propinaValue.text = '${data.propina.value}';
    servicioValue.text = '${data.servicio.value}';
    montofijoValue.text = '${data.montofijo.value}';

    return Form(
        // key: _formKeyShop,
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
                                        initialValue: data.codeShop,
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
                                        onChanged: (String? codigoComercio) {
                                          if (codigoComercio != null ||
                                              codigoComercio!.isNotEmpty) {
                                            data.codeShop = codigoComercio;
                                            log('Saved: $codigoComercio in data.codeShop');
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
                                        onChanged: (String? seriePos) {
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
                                  onChanged: (String? direction) {
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
                                        onChanged: (String? phone) {
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
                                        onChanged: (String? ciudad) {
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
                                        onChanged: (String? ruc) {
                                          if(ruc != null || ruc!.isNotEmpty){
                                            data.ruc = ruc;
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
                    title: 'PARAMETROS G03_VARIABLES',
                    tiles: [
                      CustomTile(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ToggleButtomTile(
                            title: 'CON IVA',
                            bottoms: const [
                              'IVA 0%',
                              'IVA 12%',
                              'IVA 0% & IVA 12%'
                            ],
                            defaultIndex: data.conIVA0,
                            change: (int index) {
                              data.conIVA0 = index;
                              log('Cambio en ConIVA: ${data.conIVA0}');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'PARAMETROS CLT IAD',
                    tiles: [
                      CustomTile(
                          child: SwitchCustomTile(
                            title: 'IVA',
                            initValue: data.iva.active,
                            keepState: true,
                            children: [
                              ToggleButtomTile(
                                title: 'TIPO DE PROCESO',
                                bottoms: const ['MANUAL', 'CARGADO', 'DESGLOSADO'],
                                defaultIndex: data.iva.typeProcess - 1,
                                change: (int index) {
                                  data.iva.typeProcess = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.iva.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'TIPO DE VALOR',
                                bottoms: const ['TASA POCENTUAL', 'VALOR FIJO'],
                                defaultIndex: data.iva.typeValue - 1,
                                change: (int index) {
                                  data.iva.typeValue = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.iva.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'VALOR DE BASE',
                                bottoms: const [
                                  'MONTO DEL 12%',
                                  'SUBTOTAL',
                                  'MONTO DEL 0%'
                                ],
                                defaultIndex: data.iva.base,
                                change: (int index) {
                                  data.iva.base = index;
                                  log('Cambio en Tipo de Proceso: ${data.iva.typeProcess}');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'VALOR',
                                        style: blackStyle.copyWith(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25.h,
                                      child: TextFormField(
                                        controller: ivaValue,
                                        decoration: const InputDecoration(
                                          label: Text('VALOR DE IVA'),
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (iva) {
                                          if (iva != null || iva!.isNotEmpty) {
                                            return null;
                                          }

                                          return 'CAMPO OBLIGATORIO';
                                        },
                                        onChanged: (String? iva) {
                                          if (iva != null && iva.isNotEmpty) {
                                            data.iva.value = int.parse(iva);
                                          } else {
                                            data.iva.value = 0;
                                          }
                                        },
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeIVA(1, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeIVA(1, '1');
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeIVA(10, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeIVA(10, '-');
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                    // TextField(
                                    //   controller: ivaValue,
                                    //   decoration: const InputDecoration(
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   onChanged: (String? iva) {
                                    //     log('$iva');
                                    //     // if (iva == null || iva.isEmpty) {
                                    //     //   if (double.tryParse(iva!) != null) {}
                                    //     // }
                                    //   },
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      CustomTile(
                          child: SwitchCustomTile(
                            title: 'PROPINA',
                            initValue: data.propina.active,
                            children: [
                              ToggleButtomTile(
                                title: 'TIPO DE PROCESO',
                                bottoms: const ['MANUAL', 'CARGADO', 'DESGLOSADO'],
                                defaultIndex: data.propina.typeProcess - 1,
                                change: (int index) {
                                  data.propina.typeProcess = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.propina.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'TIPO DE VALOR',
                                bottoms: const ['TASA POCENTUAL', 'VALOR FIJO'],
                                defaultIndex: data.propina.typeValue - 1,
                                change: (int index) {
                                  data.propina.typeValue = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.propina.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'VALOR DE BASE',
                                bottoms: const [
                                  'MONTO DEL 12%',
                                  'SUBTOTAL',
                                  'MONTO DEL 0%'
                                ],
                                defaultIndex: data.propina.base,
                                change: (int index) {
                                  data.propina.base = index;
                                  log('Cambio en Tipo de Proceso: ${data.propina.typeProcess}');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'VALOR',
                                        style: blackStyle.copyWith(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25.h,
                                      child: TextFormField(
                                        controller: propinaValue,
                                        decoration: const InputDecoration(
                                          label: Text('VALOR DE LA PROPINA'),
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (propina) {
                                          if (propina != null ||
                                              propina!.isNotEmpty) {
                                            return null;
                                          }

                                          return 'CAMPO OBLIGATORIO';
                                        },
                                        onChanged: (String? propina) {
                                          if (propina != null && propina.isNotEmpty) {
                                            data.propina.value = int.parse(propina);
                                          } else {
                                            data.propina.value = 0;
                                          }
                                        },

                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changePropina(1, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changePropina(1, '1');
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changePropina(10, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changePropina(10, '-');
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                    // TextField(
                                    //   controller: ivaValue,
                                    //   decoration: const InputDecoration(
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   onChanged: (String? iva) {
                                    //     log('$iva');
                                    //     // if (iva == null || iva.isEmpty) {
                                    //     //   if (double.tryParse(iva!) != null) {}
                                    //     // }
                                    //   },
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      CustomTile(
                          child: SwitchCustomTile(
                            title: 'SERVICIO',
                            initValue: data.servicio.active,
                            children: [
                              ToggleButtomTile(
                                title: 'TIPO DE PROCESO',
                                bottoms: const ['MANUAL', 'CARGADO', 'DESGLOSADO'],
                                defaultIndex: data.servicio.typeProcess - 1,
                                change: (int index) {
                                  data.servicio.typeProcess = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.servicio.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'TIPO DE VALOR',
                                bottoms: const ['TASA POCENTUAL', 'VALOR FIJO'],
                                defaultIndex: data.servicio.typeValue - 1,
                                change: (int index) {
                                  data.servicio.typeValue = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.servicio.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'VALOR DE BASE',
                                bottoms: const [
                                  'MONTO DEL 12%',
                                  'SUBTOTAL',
                                  'MONTO DEL 0%'
                                ],
                                defaultIndex: data.servicio.base,
                                change: (int index) {
                                  data.servicio.base = index;
                                  log('Cambio en Tipo de Proceso: ${data.servicio.typeProcess}');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'VALOR',
                                        style: blackStyle.copyWith(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25.h,
                                      child: TextFormField(
                                        controller: servicioValue,
                                        decoration: const InputDecoration(
                                          label: Text('VALOR DEL SERVICIO'),
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (servicio) {
                                          if (servicio != null ||
                                              servicio!.isNotEmpty) {
                                            return null;
                                          }

                                          return 'CAMPO OBLIGATORIO';
                                        },
                                        onChanged: (String? servicio) {
                                          if (servicio != null && servicio.isNotEmpty) {
                                            data.servicio.value = int.parse(servicio);
                                          } else {
                                            data.servicio.value = 0;
                                          }
                                        },
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeServicio(1, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeServicio(1, '1');
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeServicio(10, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeServicio(10, '-');
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                    // TextField(
                                    //   controller: ivaValue,
                                    //   decoration: const InputDecoration(
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   onChanged: (String? iva) {
                                    //     log('$iva');
                                    //     // if (iva == null || iva.isEmpty) {
                                    //     //   if (double.tryParse(iva!) != null) {}
                                    //     // }
                                    //   },
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      CustomTile(
                          child: SwitchCustomTile(
                            title: 'MONTO FIJO',
                            initValue: data.montofijo.active,
                            children: [
                              ToggleButtomTile(
                                title: 'TIPO DE PROCESO',
                                bottoms: const ['MANUAL', 'CARGADO', 'DESGLOSADO'],
                                defaultIndex: data.montofijo.typeProcess - 1,
                                change: (int index) {
                                  data.montofijo.typeProcess = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.montofijo.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'TIPO DE VALOR',
                                bottoms: const ['TASA POCENTUAL', 'VALOR FIJO'],
                                defaultIndex: data.montofijo.typeValue - 1,
                                change: (int index) {
                                  data.montofijo.typeValue = index + 1;
                                  log('Cambio en Tipo de Proceso: ${data.montofijo.typeProcess}');
                                },
                              ),
                              ToggleButtomTile(
                                title: 'VALOR DE BASE',
                                bottoms: const [
                                  'MONTO DEL 12%',
                                  'SUBTOTAL',
                                  'MONTO DEL 0%'
                                ],
                                defaultIndex: data.montofijo.base,
                                change: (int index) {
                                  data.montofijo.base = index;
                                  log('Cambio en Tipo de Proceso: ${data.montofijo.typeProcess}');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'VALOR',
                                        style: blackStyle.copyWith(
                                            fontSize: 6.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25.h,
                                      child: TextFormField(
                                        controller: montofijoValue,
                                        decoration: const InputDecoration(
                                          label: Text('VALOR DE IVA'),
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: (iva) {
                                          if (iva != null || iva!.isNotEmpty) {
                                            return null;
                                          }

                                          return 'CAMPO OBLIGATORIO';
                                        },
                                        onChanged: (String? montofijo) {
                                          if (montofijo != null &&
                                              montofijo.isNotEmpty) {
                                            data.montofijo.value =
                                                int.parse(montofijo);
                                          } else {
                                            data.montofijo.value = 0;
                                          }
                                        },
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeMontoFijo(1, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-1',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeMontoFijo(1, '1');
                                                  }),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '+10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeMontoFijo(10, '+');
                                                  }),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: TextButton(
                                                  child: const Text(
                                                    '-10',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    changeMontoFijo(10, '-');
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                    // TextField(
                                    //   controller: ivaValue,
                                    //   decoration: const InputDecoration(
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   onChanged: (String? iva) {
                                    //     log('$iva');
                                    //     // if (iva == null || iva.isEmpty) {
                                    //     //   if (double.tryParse(iva!) != null) {}
                                    //     // }
                                    //   },
                                    // )
                                  ],
                                ),
                              ),
                            ],
                          )),

                    ],
                  ),
                  CustomSection(
                      child: const CustomTile(
                          child: SizedBox(
                            height: 50,
                          )))
                ],
              ),
            )
          ],
        ),
      );
    }

  void changeIVA(int value, String signo) {
    log('value: $value, signo: $signo');

    ivaValue.text = signo.contains('+')
        ? (data.iva.value + value).toString()
        : (data.iva.value - value).toString();

    data.iva.value = signo.contains('+')
        ? (data.iva.value + value)
        : (data.iva.value - value);

    if (data.iva.value <= 0) {
      ivaValue.text = '0';
      data.iva.value = 0;
    }
    log(ivaValue.text);
  }

  void changePropina(int value, String signo) {
    log('value: $value, signo: $signo');

    propinaValue.text = signo.contains('+')
        ? (data.propina.value + value).toString()
        : (data.propina.value - value).toString();

    data.propina.value = signo.contains('+')
        ? (data.propina.value + value)
        : (data.propina.value - value);

    if (data.propina.value <= 0) {
      propinaValue.text = '0';
      data.propina.value = 0;
    }
    log(propinaValue.text);
  }

  void changeServicio(int value, String signo) {
    log('value: $value, signo: $signo');

    servicioValue.text = signo.contains('+')
        ? (data.servicio.value + value).toString()
        : (data.servicio.value - value).toString();

    data.servicio.value = signo.contains('+')
        ? (data.servicio.value + value)
        : (data.servicio.value - value);

    if (data.servicio.value <= 0) {
      servicioValue.text = '0';
      data.servicio.value = 0;
    }
    log(servicioValue.text);
  }

  void changeMontoFijo(int value, String signo) {
    log('value: $value, signo: $signo');

    montofijoValue.text = signo.contains('+')
        ? (data.montofijo.value + value).toString()
        : (data.montofijo.value - value).toString();

    data.montofijo.value = signo.contains('+')
        ? (data.montofijo.value + value)
        : (data.montofijo.value - value);

    if (data.montofijo.value <= 0) {
      montofijoValue.text = '0';
      data.montofijo.value = 0;
    }
    log(montofijoValue.text);
  }
}
