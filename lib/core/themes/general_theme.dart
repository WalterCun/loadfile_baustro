// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:austro_digital/core/themes/fonts_theme.dart';
// import 'package:austro_digital/global_var.dart';
// import 'package:date_format/date_format.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:http/http.dart';
// import 'package:image/image.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:sizer/sizer.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:unique_identifier/unique_identifier.dart';
//
// import '../../apps/cerrar_sesion/controller/at_logout_controller.dart';
// import '../../apps/home/screens/home_page.dart';
// import '../../apps/posicion_consolidada/controllers/pc_compartir_informacion_ejecutiva.dart';
// import '../../main.dart';
// import '../models/img_model.dart';
// import '../settings/environments/environment.dart';
// import '../settings/paths_img.dart';
// import '../widgets/pop-ups/general_popup.dart';
//
// class Utils {
//   final ScreenshotController screenshotController = ScreenshotController();
//
//   static void popUpDatosCuenta(BuildContext context, cEncriptada,
//       String tipoCuenta, Imagen imagen, void Function()? toggleLoading) async {
//     final CompartirInformacionEjecutiva _consumo =
//     CompartirInformacionEjecutiva();
//     if (toggleLoading != null) {
//       toggleLoading();
//     }
//     await _consumo.obtenerInformacion(cEncriptada);
//     if (toggleLoading != null) {
//       toggleLoading();
//     }
//     if (_consumo.todoOk) {
//       _consumo.todoOk = false;
//       showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return GeneralPopUp(
//             showCloseButton: true,
//             context: context,
//             title: 'DATOS DE CUENTA',
//             iconPath: imagen.path,
//             customText: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   tipoCuenta.toUpperCase(),
//                   style: heavyBlue.copyWith(fontSize: 13.sp),
//                 ),
//                 Text(
//                   'Nº ${_consumo.cuentaClaro}',
//                   style: blue.copyWith(fontSize: 10.sp),
//                 ),
//                 Text(
//                   'TITULAR:',
//                   style: heavyBlue.copyWith(fontSize: 13.sp),
//                 ),
//                 if (_consumo.identificacionTitular?.isNotEmpty ?? false)
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'IDENTIFICACIÓN: ',
//                         style: boldBlue.copyWith(fontSize: 10.sp),
//                       ),
//                       SizedBox(width: 0.5.w),
//                       Flexible(
//                         child: Text(
//                           _consumo.identificacionTitular ?? '',
//                           style: blue.copyWith(fontSize: 10.sp),
//                         ),
//                       )
//                     ],
//                   ),
//                 Text(
//                   _consumo.nombreTitular ?? '',
//                   style: blue.copyWith(fontSize: 10.sp),
//                 ),
//               ],
//             ),
//             mainText: 'COMPARTIR',
//             fontSize: 11.5.sp,
//             mainAction: () {
//               compartirInformacion(_consumo, tipoCuenta);
//             },
//             horizontalFormat: true,
//           );
//         },
//       );
//     } else {
//       Utils.showError(
//         texto: 'No pudimos obtener los datos de la cuenta. Intenta más tarde.',
//         forceMyMessages: true,
//       );
//     }
//   }
//
// //Método para compartir información
//   static void compartirInformacion(
//       CompartirInformacionEjecutiva infoCuenta, String tipoCuenta) async {
//     Share.share('BANCO DEL AUSTRO \n'
//         '$tipoCuenta: ${infoCuenta.cuentaClaro} \n '
//         'TITULAR: ${infoCuenta.nombreTitular} \n '
//         'C.I: ${infoCuenta.identificacionTitular}');
//   }
//
//   static void popUpDatosEjecutivo(
//       BuildContext context, cEncriptada, Function()? toggleLoading) async {
//     final CompartirInformacionEjecutiva _consumo =
//     CompartirInformacionEjecutiva();
//     if (toggleLoading != null) {
//       toggleLoading();
//     }
//     await _consumo.obtenerInformacion(cEncriptada);
//     if (toggleLoading != null) {
//       toggleLoading();
//     }
//     if (_consumo.estadoOficialCuenta == 'ACT') {
//       showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           return GeneralPopUp(
//             dismissible: true,
//             bothButtonsBlue: true,
//             showCloseButton: true,
//             context: context,
//             title: 'EJECUTIVO DE CUENTA',
//             iconPath: imgATusuario.path,
//             text: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: RichText(
//                     text: TextSpan(children: <TextSpan>[
//                       TextSpan(
//                         text: '${_consumo.nombreOficialCuenta} \n',
//                         style: boldBlue.copyWith(fontSize: 12.sp),
//                       ),
//                       if (_consumo.mailOficialCuenta?.isNotEmpty ?? false)
//                         TextSpan(
//                           text: '${_consumo.mailOficialCuenta}\n'.toLowerCase(),
//                         ),
//                       if (_consumo.banderaCelularOficialCuenta == '1')
//                         TextSpan(
//                           text: '${_consumo.celularOficialCuenta}',
//                         ),
//                     ], style: blue),
//                   ),
//                 ),
//               ],
//             ),
//             mainText: _consumo.banderaCelularOficialCuenta == '1'
//                 ? 'MENSAJE WHATSAPP'
//                 : 'ACEPTAR',
//             secondText: _consumo.banderaCelularOficialCuenta == '1'
//                 ? 'GUARDAR CONTACTO'
//                 : null,
//             fontSize: 10.sp,
//             mainAction: _consumo.banderaCelularOficialCuenta == '1'
//                 ? () {
//               enviarMensajeWhatsappEjecutivoCuenta(_consumo, context);
//             }
//                 : null,
//             showSecondButton: true,
//             secondAction: _consumo.banderaCelularOficialCuenta == '1'
//                 ? () {
//               guardarContactoOficialCuenta(_consumo);
//             }
//                 : null,
//             horizontalFormat: true,
//           );
//         },
//       );
//     } else {
//       showError(
//         title: 'Lo sentimos.',
//         texto:
//         'No encontramos el Oficial asignado, por favor acércate a tu agencia más cercana.',
//       );
//     }
//   }
//
//   //Método para enviar mensaje a Whatsapp
//   static void enviarMensajeWhatsappEjecutivoCuenta(
//       CompartirInformacionEjecutiva infoCuenta, BuildContext context) async {
//     try {
//       String whatsappUrl =
//           'whatsapp://send?phone=+593${infoCuenta.celularOficialCuenta}'
//           '&text=${Uri.encodeComponent("!Buen día!\nMi nombre es ${infoCuenta.nombreTitular}, le contacto desde AustroDigital, tengo una consulta acerca de mi cuenta. ¿Podría ayudarme?")}';
//       await launchUrlString(whatsappUrl);
//     } catch (e) {
//       showError(
//           title: 'Lo sentimos.',
//           texto: 'No se pudo enviar el mensaje vía Whatsapp.');
//     }
//   }
//
//   //Método para guardar contacto
//   static void guardarContactoOficialCuenta(
//       CompartirInformacionEjecutiva infoCuenta) async {
//     if (await FlutterContacts.requestPermission()) {
//       final nombredividido = infoCuenta.nombreOficialCuenta!.split(' ');
//
//       final newContact = Contact()
//         ..name.last = nombredividido[0].substring(0, 1).toUpperCase() +
//             nombredividido[0].substring(1).toLowerCase() +
//             ' ' +
//             nombredividido[1].substring(0, 1).toUpperCase() +
//             nombredividido[1].substring(1).toLowerCase()
//         ..name.first = nombredividido[2].substring(0, 1).toUpperCase() +
//             nombredividido[2].substring(1).toLowerCase() +
//             ' ' +
//             nombredividido[3].substring(0, 1).toUpperCase() +
//             nombredividido[3].substring(1).toLowerCase()
//         ..organizations = [
//           Organization(
//               company: 'Banco del Austro',
//               jobDescription: 'Oficial de Cuenta',
//               title: 'Oficial de Cuenta')
//         ]
//         ..emails = [
//           Email(infoCuenta.mailOficialCuenta!.toLowerCase(),
//               isPrimary: true, label: EmailLabel.work)
//         ]
//         ..phones = [
//           Phone(infoCuenta.celularOficialCuenta!,
//               isPrimary: true, label: PhoneLabel.workMobile)
//         ];
//       await FlutterContacts.openExternalEdit((await newContact.insert()).id);
//     }
//   }
//
//   static String formatearFecha(DateTime fecha, {String format = 'normal'}) {
//     if (format == 'normal') {
//       return formatDate(fecha, [dd, ' de ', MM, ' del ', yyyy],
//           locale: const SpanishDateLocale())
//           .toUpperCase();
//     } else if (format == 'dia-mes-año') {
//       return formatDate(fecha, [dd, '-', mm, '-', yyyy]);
//     } else if (format == 'mes 2ultimosdigitosdelaño') {
//       String v =
//       formatDate(fecha, [MM, ' ', yyyy], locale: const SpanishDateLocale())
//           .toUpperCase();
//       return v.replaceRange(v.length - 4, v.length - 2, '');
//     } else if (format == 'dia/mes/año 24hora:minutos') {
//       return formatDate(fecha, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
//     } else if (format == 'yyyy-mm-dd' || format == 'año-mes-día') {
//       return formatDate(fecha, [yyyy, '-', mm, '-', dd]);
//     } else if (format == 'yyyy/mm/dd' || format == 'año/mes/día') {
//       return formatDate(fecha, [yyyy, '/', mm, '/', dd]);
//     } else if (format == 'dd/mm/yy') {
//       return formatDate(fecha, [dd, '/', mm, '/', yy]);
//     } else if (format == 'dd/mm/yyyy') {
//       return formatDate(fecha, [dd, '/', mm, '/', yyyy]);
//     }
//     return formatDate(fecha, [dd, ' de ', MM, ' del ', yyyy],
//         locale: const SpanishDateLocale())
//         .toUpperCase();
//   }
//
//   static DateTime? dateTimeFromString(String fecha) {
//     DateTime? date = DateTime.tryParse(fecha);
//     if (date == null) {
//       List<String>? diaMesAnio;
//       if (fecha.contains(' ')) {
//         List<String> vector = fecha.split(' ');
//         if (vector.length == 2) {
//           if (vector[0].contains('-')) {
//             diaMesAnio = getDayMonthAndYear(vector[0], '-');
//           } else if (vector[0].contains('/')) {
//             diaMesAnio = getDayMonthAndYear(vector[0], '-');
//           } else if (vector[1].contains('-')) {
//             diaMesAnio = getDayMonthAndYear(vector[1], '-');
//           } else if (vector[1].contains('/')) {
//             diaMesAnio = getDayMonthAndYear(vector[1], '/');
//           }
//         }
//       } else {
//         if (fecha.contains('-')) {
//           diaMesAnio = getDayMonthAndYear(fecha, '-');
//         } else if (fecha.contains('/')) {
//           diaMesAnio = getDayMonthAndYear(fecha, '-');
//         }
//       }
//       if (diaMesAnio != null) {
//         date = DateTime(int.parse(diaMesAnio[2]), int.parse(diaMesAnio[1]),
//             int.parse(diaMesAnio[0]));
//       }
//     }
//     return date;
//   }
//
//   static List<String>? getDayMonthAndYear(
//       String stringDate, String splitCharacter) {
//     List<String>? diaMesAnioEntregado;
//     List<String> diaMesAnio = [];
//     diaMesAnioEntregado = stringDate.split(splitCharacter);
//     if (diaMesAnioEntregado.length == 3) {
//       if (diaMesAnioEntregado[2].length == 4) {
//         diaMesAnio.add(diaMesAnioEntregado[0]);
//         diaMesAnio.add(diaMesAnioEntregado[1]);
//         diaMesAnio.add(diaMesAnioEntregado[2]);
//       } else {
//         if (diaMesAnioEntregado[0].length == 4) {
//           diaMesAnio.add(diaMesAnioEntregado[2]);
//           diaMesAnio.add(diaMesAnioEntregado[1]);
//           diaMesAnio.add(diaMesAnioEntregado[0]);
//         }
//       }
//     }
//     if (diaMesAnio.isNotEmpty) {
//       return diaMesAnio;
//     } else {
//       return null;
//     }
//   }
//
//   ///
//   static String? validarCampos(
//       String? value, String fieldType, String fieldName,
//       {bool canBeEmpty = false,
//         bool getErrors = true,
//         TextEditingController? otherTextController,
//         String? noNullMessage,
//         String? personalizedMessage}) {
//     String mensajeFinal = '';
//     if (fieldType.contains(';')) {
//       List<String> fieldTypes = fieldType.split(';');
//       for (String fieldType in fieldTypes) {
//         String? validacionActual = validarCampos(value, fieldType, fieldName,
//             canBeEmpty: canBeEmpty,
//             getErrors: getErrors,
//             otherTextController: otherTextController,
//             noNullMessage: noNullMessage,
//             personalizedMessage: personalizedMessage);
//         if (validacionActual != null) {
//           return validacionActual;
//         }
//       }
//       return null;
//     }
//     if (value == null || value.isEmpty || value == 'null') {
//       if (!canBeEmpty) {
//         mensajeFinal = getErrors
//             ? noNullMessage ??
//             (fieldName.isNotEmpty
//                 ? 'El campo ' + fieldName.toLowerCase() + ' es obligatorio.'
//                 : 'El campo es obligatorio.')
//             : noNullMessage ?? '';
//         return mensajeFinal.toUpperCase();
//       } else {
//         return null;
//       }
//     } else {
//       if (!canBeEmpty) {
//         int whiteSpaces = 0;
//         for (var i = 0; i < value.length; i++) {
//           if (value[i] == ' ') {
//             whiteSpaces++;
//           }
//         }
//         if (whiteSpaces == value.length) {
//           mensajeFinal = getErrors
//               ? (noNullMessage ??
//               (fieldName.isNotEmpty
//                   ? 'El campo ' +
//                   fieldName.toLowerCase() +
//                   ' es obligatorio.'
//                   : 'El campo es obligatorio.'))
//               : '';
//           return mensajeFinal.toUpperCase();
//         }
//       }
//     }
//     if (fieldType.startsWith('eq:') ||
//         fieldType.startsWith('gt:') ||
//         fieldType.startsWith('gte:') ||
//         fieldType.startsWith('lt:') ||
//         fieldType.startsWith('lte:') ||
//         fieldType.startsWith('in:') ||
//         fieldType.startsWith('nin:') ||
//         fieldType.startsWith('min:') ||
//         fieldType.startsWith('max:') ||
//         fieldType.startsWith('min_max:') ||
//         fieldType.startsWith('after_date:') ||
//         fieldType.startsWith('before_date:') ||
//         fieldType.startsWith('between_dates:') ||
//         fieldType.startsWith('contains:')) {
//       List<String> vector = fieldType.split(':');
//       bool continuar = false;
//       if (vector.length == 2 || vector.length == 3) {
//         continuar = true;
//       } else {
//         if (vector.isNotEmpty) {
//           List<String> nuevoVector = List.from(vector);
//           nuevoVector.removeAt(0);
//           nuevoVector.removeAt(0);
//           vector[1] = nuevoVector.join(':');
//           continuar = true;
//         }
//       }
//       if (continuar) {
//         switch (vector[0]) {
//           case 'eq':
//             late String actualValue;
//             late String valorAComparar;
//             String? customMessage;
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = vectorDeValores[0];
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   valorAComparar = newVector[0];
//                   customMessage = newVector[1];
//                 } else {
//                   valorAComparar = vectorDeValores[1];
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = value;
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valorAComparar = newVector[0];
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir.';
//                 }
//               } else {
//                 valorAComparar = vector[1];
//               }
//             }
//             if (actualValue != valorAComparar) {
//               if (customMessage != null) {
//                 if (customMessage.endsWith('*')) {
//                   mensajeFinal = getErrors
//                       ? customMessage.substring(0, customMessage.length - 1)
//                       : '';
//                 } else {
//                   mensajeFinal = getErrors
//                       ? '$customMessage (Debe ser igual a $valorAComparar)'
//                       : '';
//                 }
//               } else {
//                 mensajeFinal = getErrors
//                     ? 'El valor debe ser igual a $valorAComparar'
//                     : '';
//               }
//               return mensajeFinal.toUpperCase();
//             }
//             return null;
//           case 'gt':
//             num? actualValue;
//             num? valorAComparar;
//             String? customMessage;
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = num.tryParse(vectorDeValores[0]);
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   valorAComparar = num.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   valorAComparar = num.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = num.tryParse(formatDollars(value));
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valorAComparar = num.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir.';
//                 }
//               } else {
//                 valorAComparar = num.tryParse(vector[1]);
//               }
//             }
//             if (valorAComparar != null) {
//               if (actualValue != null) {
//                 if (actualValue <= valorAComparar) {
//                   if (valorAComparar.toStringAsFixed(2).split('.')[1] == '00') {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Mayor a ${valorAComparar.toInt()})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser mayor a ${valorAComparar.toInt()}'
//                           : '';
//                     }
//                   } else {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Mayor a ${valorAComparar.toStringAsFixed(2)})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser mayor a ${valorAComparar.toStringAsFixed(2)}'
//                           : '';
//                     }
//                   }
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 mensajeFinal = getErrors ? 'Ingrese un valor numérico' : '';
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//             return null;
//           case 'gte':
//             num? actualValue;
//             num? valorAComparar;
//             String? customMessage;
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = num.tryParse(vectorDeValores[0]);
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> vecNumMess = vectorDeValores[1].split('|');
//                   if (vecNumMess.length == 2) {
//                     valorAComparar = num.tryParse(vecNumMess[0]);
//                     customMessage = vecNumMess[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   valorAComparar = num.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = num.tryParse(formatDollars(value));
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valorAComparar = num.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 valorAComparar = num.tryParse(vector[1]);
//               }
//             }
//             if (valorAComparar != null) {
//               if (actualValue != null) {
//                 if (actualValue < valorAComparar) {
//                   if (valorAComparar.toStringAsFixed(2).split('.')[1] == '00') {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Mayor o igual a ${valorAComparar.toInt()})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser mayor o igual a ${valorAComparar.toInt()}'
//                           : '';
//                     }
//                   } else {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Mayor o igual a ${valorAComparar.toStringAsFixed(2)})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser mayor o igual a ${valorAComparar.toStringAsFixed(2)}'
//                           : '';
//                     }
//                   }
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 mensajeFinal = getErrors ? 'Ingrese un valor numérico' : '';
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'lt':
//             num? actualValue;
//             num? valorAComparar;
//             String? customMessage;
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = num.tryParse(vectorDeValores[0]);
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   if (newVector.length == 2) {
//                     valorAComparar = num.tryParse(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   valorAComparar = num.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = num.tryParse(formatDollars(value));
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valorAComparar = num.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 valorAComparar = num.tryParse(vector[1]);
//               }
//             }
//
//             if (valorAComparar != null) {
//               if (actualValue != null) {
//                 if (actualValue >= valorAComparar) {
//                   if (valorAComparar.toStringAsFixed(2).split('.')[1] == '00') {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Menor a ${valorAComparar.toInt()})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser menor a ${valorAComparar.toInt()}'
//                           : '';
//                     }
//                   } else {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Menor a ${valorAComparar.toStringAsFixed(2)})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser menor a ${valorAComparar.toStringAsFixed(2)}'
//                           : '';
//                     }
//                   }
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 mensajeFinal = getErrors ? 'Ingrese un valor numérico' : '';
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//             return null;
//           case 'lte':
//             num? actualValue;
//             num? valorAComparar;
//             String? customMessage;
//
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = num.tryParse(vectorDeValores[0]);
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   if (newVector.length == 2) {
//                     valorAComparar = num.tryParse(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   valorAComparar = num.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = num.tryParse(formatDollars(value));
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valorAComparar = num.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 valorAComparar = num.tryParse(vector[1]);
//               }
//             }
//
//             if (valorAComparar != null) {
//               if (actualValue != null) {
//                 if (actualValue > valorAComparar) {
//                   if (valorAComparar.toStringAsFixed(2).split('.')[1] == '00') {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Menor o igual a ${valorAComparar.toInt()})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser menor o igual a ${valorAComparar.toInt()}'
//                           : '';
//                     }
//                   } else {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Menor o igual a ${valorAComparar.toStringAsFixed(2)})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'El valor debe ser menor o igual a ${valorAComparar.toStringAsFixed(2)}'
//                           : '';
//                     }
//                   }
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 mensajeFinal = getErrors ? 'Ingrese un valor numérico' : '';
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//
//             return null;
//           case 'in':
//             late String actualValue;
//             dynamic lista;
//             String? customMessage;
//
//             try {
//               if (vector[1].contains('\\')) {
//                 List<String> vectorDeValores = vector[1].split('\\');
//                 if (vectorDeValores.length == 2) {
//                   actualValue = vectorDeValores[0];
//                   if (vectorDeValores[1].contains('|')) {
//                     List<String> newVector = vectorDeValores[1].split('|');
//                     if (newVector.length == 2) {
//                       lista = jsonDecode(newVector[0]);
//                       customMessage = newVector[1];
//                     } else {
//                       return 'No debería ocurrir';
//                     }
//                   } else {
//                     lista = jsonDecode(vectorDeValores[1]);
//                   }
//                 } else {
//                   return 'No debería ocurrir.';
//                 }
//               } else {
//                 actualValue = value;
//                 if (vector[1].contains('|')) {
//                   List<String> newVector = vector[1].split('|');
//                   if (newVector.length == 2) {
//                     lista = jsonDecode(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   lista = jsonDecode(vector[1]);
//                 }
//               }
//
//               lista = lista as List<dynamic>;
//               for (dynamic objeto in lista) {
//                 lista[lista.indexOf(objeto)] = objeto.toString();
//               }
//
//               if (!lista.contains(actualValue)) {
//                 if (customMessage != null) {
//                   if (customMessage.endsWith('*')) {
//                     mensajeFinal = getErrors
//                         ? customMessage.substring(0, customMessage.length - 1)
//                         : '';
//                   } else {
//                     String mensaje = 'Debe ser: ';
//                     lista = lista.toSet().toList();
//                     for (String obj in lista) {
//                       mensaje += obj + ' o ';
//                     }
//                     mensaje = mensaje.substring(0, mensaje.length - 3) + '.';
//                     mensajeFinal = getErrors ? '$customMessage ($mensaje)' : '';
//                   }
//                 } else {
//                   String mensaje =
//                       'Se debe ingresar alguno de los siguientes valores: ';
//                   lista = lista.toSet().toList();
//                   for (String obj in lista) {
//                     mensaje += obj + ', ';
//                   }
//                   mensaje = mensaje.substring(0, mensaje.length - 2) + '.';
//                   mensajeFinal = getErrors ? mensaje : '';
//                 }
//                 return mensajeFinal.toUpperCase().replaceAll(' O ', ' o ');
//               }
//             } catch (e) {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'nin':
//             late String actualValue;
//             dynamic lista;
//             String? customMessage;
//             try {
//               if (vector[1].contains('\\')) {
//                 List<String> vectorDeValores = vector[1].split('\\');
//                 if (vectorDeValores.length == 2) {
//                   actualValue = vectorDeValores[0];
//                   if (vectorDeValores[1].contains('|')) {
//                     List<String> newVector = vectorDeValores[1].split('|');
//                     if (newVector.length == 2) {
//                       lista = jsonDecode(newVector[0]);
//                       customMessage = newVector[1];
//                     } else {
//                       return 'No debería ocurrir';
//                     }
//                   } else {
//                     lista = jsonDecode(vectorDeValores[1]);
//                   }
//                 } else {
//                   return 'No debería ocurrir.';
//                 }
//               } else {
//                 actualValue = value;
//                 if (vector[1].contains('|')) {
//                   List<String> newVector = vector[1].split('|');
//                   if (newVector.length == 2) {
//                     lista = jsonDecode(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   lista = jsonDecode(vector[1]);
//                 }
//               }
//
//               lista = lista as List<dynamic>;
//               for (dynamic objeto in lista) {
//                 lista[lista.indexOf(objeto)] = objeto.toString();
//               }
//               log(lista.toString());
//               if (lista.contains(actualValue)) {
//                 if (customMessage != null) {
//                   if (customMessage.endsWith('*')) {
//                     mensajeFinal = getErrors
//                         ? customMessage.substring(0, customMessage.length - 1)
//                         : '';
//                   } else {
//                     String mensaje = 'No debe ser: ';
//                     lista = lista.toSet().toList();
//                     for (String obj in lista) {
//                       mensaje += obj + ' o ';
//                     }
//                     mensaje = mensaje.substring(0, mensaje.length - 3) + '.';
//                     mensajeFinal = getErrors ? '$customMessage ($mensaje)' : '';
//                   }
//                 } else {
//                   String mensaje =
//                       'No se puede ingresar ninguno de los siguientes valores: ';
//                   lista = lista.toSet().toList();
//                   for (String obj in lista) {
//                     mensaje += obj + ', ';
//                   }
//                   mensaje = mensaje.substring(0, mensaje.length - 2) + '.';
//                   mensajeFinal = getErrors ? mensaje : '';
//                 }
//                 return mensajeFinal.toUpperCase().replaceAll(' O ', ' o ');
//               }
//             } catch (e) {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'min':
//             late String actualValue;
//             int? valor;
//             String? customMessage;
//
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = vectorDeValores[0];
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   if (newVector.length == 2) {
//                     valor = int.tryParse(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   valor = int.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = value;
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valor = int.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 valor = int.tryParse(vector[1]);
//               }
//             }
//             if (valor != null) {
//               if (actualValue.length < valor) {
//                 if (customMessage != null) {
//                   if (customMessage.endsWith('*')) {
//                     mensajeFinal = getErrors
//                         ? customMessage.substring(0, customMessage.length - 1)
//                         : '';
//                   } else {
//                     mensajeFinal = getErrors
//                         ? '$customMessage (Mínimo $valor caracteres)'
//                         : '';
//                   }
//                 } else {
//                   mensajeFinal = getErrors
//                       ? 'Ingrese un valor de al menos $valor caracteres.'
//                       : '';
//                 }
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//             return null;
//           case 'max':
//             late String actualValue;
//             int? valor;
//             String? customMessage;
//
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = vectorDeValores[0];
//                 if (vectorDeValores[1].contains('|')) {
//                   List<String> newVector = vectorDeValores[1].split('|');
//                   if (newVector.length == 2) {
//                     valor = int.tryParse(newVector[0]);
//                     customMessage = newVector[1];
//                   } else {
//                     return 'No debería ocurrir';
//                   }
//                 } else {
//                   valor = int.tryParse(vectorDeValores[1]);
//                 }
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = value;
//               if (vector[1].contains('|')) {
//                 List<String> newVector = vector[1].split('|');
//                 if (newVector.length == 2) {
//                   valor = int.tryParse(newVector[0]);
//                   customMessage = newVector[1];
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 valor = int.tryParse(vector[1]);
//               }
//             }
//             if (valor != null) {
//               if (actualValue.length > valor) {
//                 if (customMessage != null) {
//                   if (customMessage.endsWith('*')) {
//                     mensajeFinal = getErrors
//                         ? customMessage.substring(0, customMessage.length - 1)
//                         : '';
//                   } else {
//                     mensajeFinal = getErrors
//                         ? '$customMessage (Máximo $valor caracteres)'
//                         : '';
//                   }
//                 } else {
//                   mensajeFinal = getErrors
//                       ? 'Ingrese un máximo de $valor caracteres.'
//                       : '';
//                 }
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//             return null;
//           case 'min_max':
//             late String actualValue;
//             int? valorUno;
//             int? valorDos;
//             String? customMessage;
//
//             if (vector[1].contains('\\')) {
//               List<String> vectorDeValores = vector[1].split('\\');
//               if (vectorDeValores.length == 2) {
//                 actualValue = vectorDeValores[0];
//                 valorUno = int.tryParse(vectorDeValores[1]);
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               actualValue = value;
//               valorUno = int.tryParse(vector[1]);
//             }
//
//             if (vector[2].contains('|')) {
//               List<String> newVector = vector[2].split('|');
//               if (newVector.length == 2) {
//                 valorDos = int.tryParse(newVector[0]);
//                 customMessage = newVector[1];
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               valorDos = int.tryParse(vector[2]);
//             }
//
//             if (valorUno != null && valorDos != null) {
//               if (actualValue.length < valorUno ||
//                   actualValue.length > valorDos) {
//                 if (customMessage != null) {
//                   if (customMessage.endsWith('*')) {
//                     mensajeFinal = getErrors
//                         ? customMessage.substring(0, customMessage.length - 1)
//                         : '';
//                   } else {
//                     mensajeFinal = getErrors
//                         ? '$customMessage (Mínimo $valorUno caracteres, máximo $valorDos caracteres)'
//                         : '';
//                   }
//                 } else {
//                   mensajeFinal = getErrors
//                       ? 'Ingrese un valor entre $valorUno y $valorDos caracteres.'
//                       : '';
//                 }
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               return 'No debería ocurrir.';
//             }
//             return null;
//           case 'after_date':
//             List<String> vectorFecha;
//             String? customMessage;
//             if (vector[1].contains('|')) {
//               List<String> vecNumMess = vector[1].split('|');
//               if (vecNumMess.length == 2) {
//                 vectorFecha = vecNumMess[0].split('/');
//                 customMessage = vecNumMess[1];
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               vectorFecha = vector[1].split('/');
//             }
//             List<String> vectorFechaIngresada = value.split('/');
//             if (vectorFechaIngresada.length == 3) {
//               if (vectorFecha.length == 3) {
//                 try {
//                   DateTime fecha = DateTime(int.parse(vectorFecha[2]),
//                       int.parse(vectorFecha[1]), int.parse(vectorFecha[0]));
//                   DateTime fechaIngresada = DateTime(
//                       int.parse(vectorFechaIngresada[2]),
//                       int.parse(vectorFechaIngresada[1]),
//                       int.parse(vectorFechaIngresada[0]));
//                   if (fechaIngresada.isBefore(fecha)) {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Despues de: ${vector[1].split('|')[0]})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'La fecha ingresada debe ser después de: ${vector[1]}'
//                           : '';
//                     }
//                     return mensajeFinal.toUpperCase();
//                   }
//                 } catch (e) {
//                   return 'No debería ocurrir';
//                 }
//               } else if (vectorFecha.length == 1) {
//                 if (vectorFecha[0].isEmpty || vectorFecha[0] == 'null') {
//                   mensajeFinal =
//                   getErrors ? 'Ingresa también la fecha anterior' : '';
//                   return mensajeFinal.toUpperCase();
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 return 'No debería ocurrir';
//               }
//             } else {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'before_date':
//             List<String> vectorFecha;
//             String? customMessage;
//             if (vector[1].contains('|')) {
//               List<String> vecDateMess = vector[1].split('|');
//               if (vecDateMess.length == 2) {
//                 vectorFecha = vecDateMess[0].split('/');
//                 customMessage = vecDateMess[1];
//               } else {
//                 return 'No debería ocurrir';
//               }
//             } else {
//               vectorFecha = vector[1].split('/');
//             }
//             List<String> vectorFechaIngresada = value.split('/');
//             if (vectorFechaIngresada.length == 3) {
//               if (vectorFecha.length == 3) {
//                 try {
//                   DateTime fecha = DateTime(int.parse(vectorFecha[2]),
//                       int.parse(vectorFecha[1]), int.parse(vectorFecha[0]));
//                   DateTime fechaIngresada = DateTime(
//                       int.parse(vectorFechaIngresada[2]),
//                       int.parse(vectorFechaIngresada[1]),
//                       int.parse(vectorFechaIngresada[0]));
//                   if (fechaIngresada.isAfter(fecha)) {
//                     if (customMessage != null) {
//                       if (customMessage.endsWith('*')) {
//                         mensajeFinal = getErrors
//                             ? customMessage.substring(
//                             0, customMessage.length - 1)
//                             : '';
//                       } else {
//                         mensajeFinal = getErrors
//                             ? '$customMessage (Antes de: ${vector[1].split('|')[0]})'
//                             : '';
//                       }
//                     } else {
//                       mensajeFinal = getErrors
//                           ? 'La fecha ingresada debe ser antes de: ${vector[1]}'
//                           : '';
//                     }
//                     return mensajeFinal.toUpperCase();
//                   }
//                 } catch (e) {
//                   return 'No debería ocurrir';
//                 }
//               } else if (vectorFecha.length == 1) {
//                 if (vectorFecha[0].isEmpty || vectorFecha[0] == 'null') {
//                   mensajeFinal =
//                   getErrors ? 'Ingresa también la fecha posterior' : '';
//                   return mensajeFinal.toUpperCase();
//                 } else {
//                   return 'No debería ocurrir';
//                 }
//               } else {
//                 return 'No debería ocurrir';
//               }
//             } else {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'between_dates':
//             List<String> vectorFechaUno = vector[1].split('/');
//             List<String> vectorFechaDos;
//             String? customMessage;
//             if (vector[2].contains('|')) {
//               List<String> vecDateMess = vector[2].split('|');
//               if (vecDateMess.length == 2) {
//                 vectorFechaDos = vecDateMess[0].split('/');
//                 customMessage = vecDateMess[1];
//               } else {
//                 return 'No debería ocurrir';
//               }
//             } else {
//               vectorFechaDos = vector[2].split('/');
//             }
//             List<String> vectorFechaIngresada = value.split('/');
//             if (vectorFechaUno.length == 3 &&
//                 vectorFechaDos.length == 3 &&
//                 vectorFechaIngresada.length == 3) {
//               try {
//                 DateTime fechaUno = DateTime(int.parse(vectorFechaUno[2]),
//                     int.parse(vectorFechaUno[1]), int.parse(vectorFechaUno[0]));
//                 DateTime fechaDos = DateTime(int.parse(vectorFechaDos[2]),
//                     int.parse(vectorFechaDos[1]), int.parse(vectorFechaDos[0]));
//                 DateTime fechaIngresada = DateTime(
//                     int.parse(vectorFechaIngresada[2]),
//                     int.parse(vectorFechaIngresada[1]),
//                     int.parse(vectorFechaIngresada[0]));
//                 if (fechaIngresada.isBefore(fechaUno) ||
//                     fechaIngresada.isAfter(fechaDos)) {
//                   if (customMessage != null) {
//                     if (customMessage.endsWith('*')) {
//                       mensajeFinal = getErrors
//                           ? customMessage.substring(0, customMessage.length - 1)
//                           : '';
//                     } else {
//                       mensajeFinal = getErrors
//                           ? '$customMessage (Antes de: ${vector[1]} y después de: ${vector[2].split('|')[0]})'
//                           : '';
//                     }
//                   } else {
//                     mensajeFinal = getErrors
//                         ? 'La fecha ingresada debe ser antes de: ${vector[1]} y después de: ${vector[2]}'
//                         : '';
//                   }
//                   return mensajeFinal.toUpperCase();
//                 }
//               } catch (e) {
//                 return 'No debería ocurrir';
//               }
//             } else {
//               return 'No debería ocurrir';
//             }
//             return null;
//           case 'contains':
//             String realCompareValue;
//             String? customMessage;
//             if (vector[1].contains('|')) {
//               List<String> secondVec = vector[1].split('|');
//               if (secondVec.length == 2) {
//                 realCompareValue = secondVec[0];
//                 customMessage = secondVec[1];
//               } else {
//                 return 'No debería ocurrir.';
//               }
//             } else {
//               realCompareValue = vector[1];
//             }
//             if (!value.contains(realCompareValue)) {
//               if (customMessage != null) {
//                 if (customMessage.endsWith('*')) {
//                   mensajeFinal = getErrors
//                       ? customMessage.substring(0, customMessage.length - 1)
//                       : '';
//                 } else {
//                   mensajeFinal = getErrors
//                       ? '$customMessage (Debe contener el texto $realCompareValue)'
//                       : '';
//                 }
//               } else {
//                 mensajeFinal =
//                 getErrors ? 'De contener el texto $realCompareValue' : '';
//               }
//               return mensajeFinal.toUpperCase();
//             }
//             return null;
//         }
//       } else {
//         return 'No debería ocurrir';
//       }
//     } else {
//       switch (fieldType) {
//         case 'username':
//           final RegExp regExp = RegExp(r'[^0-9A-Za-z@.\-_]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'El campo ' + fieldName.toLowerCase() + ' no es válido.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           break;
//         case 'password':
//           final RegExp regExp = RegExp(r'[^0-9a-zA-Z&.\-_\\@\/$#*ñ]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'El campo ' + fieldName.toLowerCase() + ' no es válido.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'tarjeta_credito':
//           final RegExp regExp = RegExp(r'[^0-9]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Solo se permiten números'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           if (value.length != 16) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número de tarjeta es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'nro_cuenta':
//           final RegExp regExp = RegExp(r'[^0-9]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Solo se permiten números'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           if (value.length > 19) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número de cuenta es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'nro_cuenta_externa':
//           final RegExp regExp = RegExp(r'[^0-9]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Solo se permiten números'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           if (value.length < 3 || value.length > 20) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número de cuenta es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'valor_max_pago_directo':
//           double? v = double.tryParse(formatDollars(value));
//           if (v == null) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'Ingrese solo valores numéricos enteros.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           } else {
//             if (v < 1 || v > 4000) {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ??
//                   'el valor mínimo a transferir es \$ 1.00.\n el valor máximo a transferir es \$ 4000.00.'
//                   : '';
//               return mensajeFinal.toUpperCase();
//             }
//           }
//           return null;
//         case 'valor_max':
//           double? v = double.tryParse(formatDollars(value));
//           if (v == null) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'Ingrese solo valores numéricos enteros.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           } else {
//             if (v <= 0 || v > 15000) {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ??
//                   'El valor ingresado no está dentro del rango permitido.'
//                   : '';
//               return mensajeFinal.toUpperCase();
//             }
//           }
//           return null;
//         case 'valor_a_ahorrar':
//           double? v = double.tryParse(formatDollars(value));
//           if (v == null) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'Ingrese solo valores numéricos enteros.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           } else {
//             if (v < 25 || v > 50000) {
//               mensajeFinal =
//               getErrors ? personalizedMessage ?? 'Mín 25, Máx 50000.' : '';
//               return mensajeFinal.toUpperCase();
//             }
//           }
//           return null;
//         case 'otp':
//           if (value.length != 6 || int.tryParse(value) == null) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El código ingresado es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'email':
//           final RegExp reg = RegExp(
//               r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//           if (reg.hasMatch(value)) {
//             return null;
//           }
//           mensajeFinal = getErrors
//               ? personalizedMessage ?? 'EL correo eléctronico es incorrecto.'
//               : '';
//           return mensajeFinal.toUpperCase();
//         case 'alias':
//           if (value == ' ') {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El alias es incorrecto'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           } else {
//             if (value.length < 5) {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ??
//                   'Ingrese un alias de al menos 5 caracteres.'
//                   : '';
//               return mensajeFinal.toUpperCase();
//             }
//           }
//           return null;
//         case 'cedula':
//           value = value.trim();
//           if (value.length == 10) {
//             int? numeroDeCedula = int.tryParse(value);
//             if (numeroDeCedula != null) {
//               int primerosDosDigitos = int.parse(value.substring(0, 2));
//               if (primerosDosDigitos > 0 && primerosDosDigitos < 25) {
//                 int tercerDigito = int.parse(value.substring(2, 3));
//                 if (tercerDigito < 6) {
//                   int digitoVerificador = int.parse(value.substring(9, 10));
//                   int sumaTotal = 0;
//                   for (int i = 0; i < 9; i++) {
//                     if (i % 2 == 0) {
//                       int valor = int.parse(value.substring(i, i + 1)) * 2;
//                       if (valor > 9) {
//                         valor = valor - 9;
//                       }
//                       sumaTotal += valor;
//                     } else {
//                       sumaTotal += int.parse(value.substring(i, i + 1));
//                     }
//                   }
//                   int decenaInmediataSuperior = ((sumaTotal ~/ 10) * 10) + 10;
//                   int resta = decenaInmediataSuperior - sumaTotal;
//                   if (resta == 10 && digitoVerificador == 0) {
//                     return null;
//                   } else {
//                     if (resta == digitoVerificador) {
//                       return null;
//                     } else {
//                       mensajeFinal = getErrors
//                           ? personalizedMessage ??
//                           'El número de cédula es incorrecto.'
//                           : '';
//                       return mensajeFinal.toUpperCase();
//                     }
//                   }
//                 } else {
//                   mensajeFinal = getErrors
//                       ? personalizedMessage ??
//                       'El número de cédula es incorrecto.'
//                       : '';
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 if (primerosDosDigitos == 30) {
//                   return null;
//                 }
//                 mensajeFinal = getErrors
//                     ? personalizedMessage ?? 'El número de cédula es incorrecto'
//                     : '';
//               }
//             } else {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ?? 'Ingrese solo números.'
//                   : '';
//             }
//           } else {
//             mensajeFinal =
//             getErrors ? personalizedMessage ?? 'Ingrese 10 dígitos.' : '';
//           }
//           return mensajeFinal.toUpperCase();
//         case 'ruc':
//           value = value.trim();
//           if (value.length == 13) {
//             int? numeroDeRuc = int.tryParse(value);
//             if (numeroDeRuc != null) {
//               int primerosDosDigitos = int.parse(value.substring(0, 2));
//               if (primerosDosDigitos > 0 && primerosDosDigitos < 25) {
//                 int tercerDigito = int.parse(value.substring(2, 3));
//                 if (tercerDigito < 7 || tercerDigito == 9) {
//                   int digitoVerificador, iterarHasta, idLocal;
//                   List<int> digitos = [];
//                   if (tercerDigito < 6 || tercerDigito == 9) {
//                     digitoVerificador = int.parse(value.substring(9, 10));
//                     iterarHasta = 9;
//                     if (tercerDigito < 6) {
//                       digitos = [2, 1, 2, 1, 2, 1, 2, 1, 2];
//                     } else {
//                       digitos = [4, 3, 2, 7, 6, 5, 4, 3, 2];
//                     }
//                     idLocal = int.parse(value.substring(10));
//                   } else {
//                     digitoVerificador = int.parse(value.substring(8, 9));
//                     iterarHasta = 8;
//                     digitos = [3, 2, 7, 6, 5, 4, 3, 2];
//                     idLocal = int.parse(value.substring(9));
//                   }
//
//                   int sumaTotal = 0;
//                   for (int i = 0; i < iterarHasta; i++) {
//                     int valor =
//                         int.parse(value.substring(i, i + 1)) * digitos[i];
//                     if (tercerDigito < 6 && valor > 9) {
//                       valor = valor - 9;
//                     }
//                     sumaTotal += valor;
//                   }
//                   int total;
//                   if (tercerDigito < 6) {
//                     total = ((sumaTotal ~/ 10) * 10) + 10;
//                     total = total - sumaTotal;
//                     if (total == 10) {
//                       total = 0;
//                     }
//                   } else {
//                     total = 11 - (sumaTotal % 11);
//                     if (total == 11) {
//                       total = 0;
//                     }
//                   }
//                   if (total == digitoVerificador) {
//                     if (idLocal > 0) {
//                       return null;
//                     } else {
//                       mensajeFinal = getErrors
//                           ? personalizedMessage ??
//                           'El número de RUC es incorrecto.'
//                           : '';
//                       return mensajeFinal.toUpperCase();
//                     }
//                   } else {
//                     mensajeFinal = getErrors
//                         ? personalizedMessage ??
//                         'El número de RUC es incorrecto.'
//                         : '';
//                     return mensajeFinal.toUpperCase();
//                   }
//                 } else {
//                   mensajeFinal = getErrors
//                       ? personalizedMessage ?? 'El número de RUC es incorrecto.'
//                       : '';
//                   return mensajeFinal.toUpperCase();
//                 }
//               } else {
//                 mensajeFinal = getErrors
//                     ? personalizedMessage ?? 'El número de RUC es incorrecto'
//                     : '';
//               }
//             } else {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ?? 'Ingrese solo números.'
//                   : '';
//             }
//           } else {
//             mensajeFinal =
//             getErrors ? personalizedMessage ?? 'Ingrese 13 dígitos.' : '';
//           }
//           return mensajeFinal.toUpperCase();
//         case 'identificacion':
//           value = value.trim();
//           if (double.tryParse(value) == null) {
//             mensajeFinal =
//             getErrors ? personalizedMessage ?? 'Solo números' : '';
//             return mensajeFinal.toUpperCase();
//           }
//           if (value.length != 10 && value.length != 13) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'El número de identificación es incorrecto'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           } else {
//             return Utils.validarCampos(
//                 value, value.length == 10 ? 'cedula' : 'ruc', fieldName,
//                 canBeEmpty: canBeEmpty,
//                 getErrors: getErrors,
//                 otherTextController: otherTextController,
//                 noNullMessage: noNullMessage,
//                 personalizedMessage: personalizedMessage);
//           }
//         case 'pasaporte':
//           value = value.trim();
//           if (value.length < 3 || value.length > 15) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El pasaporte es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'nombre':
//           value = value.trim();
//           List<String> vectorDeNombre = value.split(' ');
//           if (vectorDeNombre.length < 2) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Ingrese los nombres completos'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//       /*
//         case 'min_length':
//           value = value.trim();
//           if (value.length < minLength) {
//             mensajeFinal = getErrors ? personalizedMessage ?? 'Ingrese al menos $minLength caracteres.' : '';
//           }
//           return null;
//         */
//         case 'phone':
//           value = value.trim();
//           if (value.length >= 9) {
//             int? numeroCelular = int.tryParse(value.replaceAll('+', '00'));
//             if (numeroCelular == null) {
//               mensajeFinal =
//               getErrors ? personalizedMessage ?? 'Solo números' : '';
//               return mensajeFinal.toUpperCase();
//             }
//           } else {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número ingresado no es correcto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'celular':
//           value = value.trim();
//           if (value.length == 10 || value.length == 9) {
//             int? numeroCelular = int.tryParse(value);
//             if (numeroCelular != null) {
//               if ((value.length == 10 && value[0] != '0') ||
//                   (value.length == 9 && value[0] == '0')) {
//                 mensajeFinal = getErrors
//                     ? personalizedMessage ??
//                     'El número de celular es incorrecto.'
//                     : '';
//                 return mensajeFinal.toUpperCase();
//               }
//             } else {
//               mensajeFinal =
//               getErrors ? personalizedMessage ?? 'Solo números' : '';
//               return mensajeFinal.toUpperCase();
//             }
//           } else {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número de celular es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'celular_*':
//           value = value.trim();
//           if (value.length == 10 || value.length == 9) {
//             if (!value.contains('*')) {
//               return Utils.validarCampos(value, 'celular', fieldName,
//                   getErrors: getErrors);
//             }
//           } else {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número de celular es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'dni':
//         case 'nif':
//         case 'nif/dni':
//         case 'dni/nif':
//         case 'dni_nif':
//         case 'nif_dni':
//           value = value.trim();
//           if (value.length >= 4 && value.length <= 25) {
//             double? number = double.tryParse(value);
//             if (number == null) {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ?? 'Ingrese solo números.'
//                   : '';
//               return mensajeFinal.toUpperCase();
//             }
//           } else {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Ingrese un DNI o NIF válido.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'cta_trjt':
//           final RegExp regExp = RegExp(r'[^0-9]');
//           if (regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'Solo se permiten números'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           if (value.length > 19 && value.length < 10) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ?? 'El número ingresado es incorrecto.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'no_caract_especi_no_tildes':
//           final RegExp regExp = RegExp(r'[a-zA-Z0-9]');
//           if (!regExp.hasMatch(value)) {
//             mensajeFinal = getErrors
//                 ? personalizedMessage ??
//                 'No se permiten caracteres especiales ni tildes.'
//                 : '';
//             return mensajeFinal.toUpperCase();
//           }
//           return null;
//         case 'same_password':
//           if (otherTextController != null) {
//             if (otherTextController.text != value) {
//               mensajeFinal = getErrors
//                   ? personalizedMessage ?? 'Las contraseñas no coinciden.'
//                   : '';
//               return mensajeFinal.toUpperCase();
//             }
//           }
//           return null;
//         default:
//           return null;
//       }
//     }
//     return null;
//   }
//
//   /// Esta funcion realiza las validaciones respectivas del valor
//   /// que recibe "[cedula]" el cual consta de:
//   /// - La validacion de longitud de 10 digitos
//   /// - Sea una cedula ecuatoriana
//   /// - Valor vacio o nulo
//   /// - No incluya otros caracteres que no sean numéricos
//   ///
//   /// de estas validaciones retorna un [Map<String, dynamic>].
//   ///
//   /// ```dart
//   /// {
//   ///  'validate':false, // retorna [true] cuando la cedula es valida
//   ///  'message': null,  // retorna mensajes de error cuando no se valido la cedula
//   ///  'data': null      // retorna valor extra como el codigo de la provincia correspondiente de la cedula
//   /// }
//   /// ```
//   ///
//   /// Ejemplo:
//   ///
//   /// Utils.validateCedula('3050286503')['validate'] // true
//   ///
//   /// Utils.validateCedula('3050286502')['validate'] // false
//   ///
//   /// Utils.validateCedula('305028650')['validate']  // false
//   ///
//   static Map<String, dynamic> validateCedula(String cedula) {
//     Map<String, dynamic> resp = {
//       'validate': false,
//       'message': null,
//       'data': null
//     };
//
//     /// Funcion de validacion de cedula ecuatoriana
//     int suma = 0, mul = 2, chars = cedula.length;
//     if (cedula.isEmpty) {
//       resp['message'] = 'ES NECESARIO LLENAR ESTE CAMPO';
//     } else {
//       if (cedula.length != 10) {
//         resp['message'] = 'LA CÉDULA DEBE TENER 10 DÍGITOS';
//       } else {
//         if (int.tryParse(cedula) != null) {
//           resp['data'] = {'provincia': cedula.substring(0, 2)};
//
//           int _prov = int.parse(resp['data']['provincia']);
//           if (_prov > 24 && _prov != 30) {
//             resp['message'] = 'LA CÉDULA INGRESADA NO ES ECUATORIANA';
//           } else {
//             for (int index = 0; index < chars; index += 1) {
//               int valor = int.parse(cedula[index]) * mul;
//               suma += valor > 9 ? valor - 9 : valor;
//               mul = (index % 2) == 0 ? 1 : 2;
//             }
//             if (suma % 10 == 0 && suma > 0) {
//               resp['validate'] = true;
//               resp['message'] = null;
//             } else {
//               resp['message'] = 'CÉDULA INGRESADA NO ES VALIDA';
//             }
//           }
//         } else {
//           resp['message'] = 'EL VALOR INGRESADO NO CORRESPONDE A UN NÚMERO';
//         }
//       }
//     }
//     return resp;
//   }
//
//   /// Este metodo se encarga de buscar dentro de una lista de [DropdownButton]
//   /// y retorna el primer valor que coincida, caso contrario retornara null
//   static String? getDescOfCat(
//       {required List<DropdownMenuItem> catalog, required String cod}) {
//     String? resp;
//     for (var element in catalog) {
//       if (element.value == cod) {
//         log('Coincidencia encontrada: ${element.toString()}',
//             name: 'Utils.getDescOfCat');
//         resp = element.toString();
//         return resp;
//       }
//     }
//     return resp;
//   }
//
//   /// Metodo estatico para eliminar objetos <Map> repetidos de una lista
//   static List<Map>? filterObjectsRepeated(List<Map<String, Object?>> subjects,
//       {String? key = 'Codigo'}) {
//     final Map<String, dynamic> mapFilter = {};
//
//     try {
//       for (Map<String, dynamic> element in subjects) {
//         mapFilter[element[key]] = element;
//       }
//     } on Exception catch (_) {
//       return null;
//     }
//
//     final List<Map<String, dynamic>> listFilter = mapFilter.keys
//         .map((key) => mapFilter[key] as Map<String, dynamic>)
//         .toList();
//
//     return listFilter;
//   }
//
//   ///
//   static String? validarCamposEspeciales(
//       String? value, String tipo, String nombreCampo,
//       {TextEditingController? otroControladorDeTexto,
//         String? cedulaCliente,
//         String? username,
//         bool getErrors = true}) {
//     if (value == null || value.isEmpty) {
//       return getErrors
//           ? 'El campo ${nombreCampo.toLowerCase()} es obligatorio.'
//           : '';
//     }
//     if (tipo.contains(';')) {
//       List<String> fieldTypes = tipo.split(';');
//       for (String fieldType in fieldTypes) {
//         if (fieldType.startsWith('eq:') ||
//             fieldType.startsWith('gt:') ||
//             fieldType.startsWith('gte:') ||
//             fieldType.startsWith('lt:') ||
//             fieldType.startsWith('lte:') ||
//             fieldType.startsWith('in:') ||
//             fieldType.startsWith('nin:') ||
//             fieldType.startsWith('min:') ||
//             fieldType.startsWith('max:') ||
//             fieldType.startsWith('min_max:') ||
//             fieldType.startsWith('after_date:') ||
//             fieldType.startsWith('before_date:') ||
//             fieldType.startsWith('between_dates:') ||
//             fieldType.startsWith('contains:')) {
//           String? validacionActual = validarCampos(
//               value, fieldType, nombreCampo,
//               canBeEmpty: false, getErrors: true);
//           if (validacionActual != null) {
//             return validacionActual;
//           }
//         } else {
//           String? validacionActual = validarCamposEspeciales(
//             value,
//             fieldType,
//             nombreCampo,
//             otroControladorDeTexto: otroControladorDeTexto,
//             cedulaCliente: cedulaCliente,
//             username: username,
//             getErrors: getErrors,
//           );
//           if (validacionActual != null) {
//             return validacionActual;
//           }
//         }
//       }
//       return null;
//     }
//     if (tipo == 'username') {
//       final RegExp regLetras = RegExp(r'[A-Z]');
//       final RegExp regNumero = RegExp(r'[0-9]');
//       bool tieneLetras = regLetras.hasMatch(value);
//       if (!tieneLetras) {
//         return getErrors ? 'Ingrese al menos una letra.' : '';
//       }
//       bool tieneNumeros = regNumero.hasMatch(value);
//       if (!tieneNumeros) {
//         return getErrors ? 'Ingrese al menos un número.' : '';
//       }
//       if (cedulaCliente != null && cedulaCliente.isNotEmpty) {
//         if (value.contains(cedulaCliente) ||
//             value.toUpperCase().contains(cedulaCliente.toUpperCase())) {
//           return getErrors
//               ? 'El nombre de usuario no puede contener la identificación del cliente.'
//               : '';
//         }
//       }
//     } else if (tipo == 'password') {
//       final RegExp regLetrasMayus = RegExp(r'[A-Z]');
//       final RegExp regLetras = RegExp(r'[a-z]');
//       final RegExp regNumero = RegExp(r'[0-9]');
//       final RegExp caracteresEspeciales = RegExp(r'[&.\-_\\@\/$#*]');
//       bool tieneLetrasMayus = regLetrasMayus.hasMatch(value);
//       if (!tieneLetrasMayus) {
//         return getErrors ? 'Ingresa al menos una mayúscula.' : '';
//       }
//       bool tieneLetras = regLetras.hasMatch(value);
//       if (!tieneLetras) {
//         return getErrors ? 'Ingrese al menos una letra mínuscula.' : '';
//       }
//       bool tieneNumeros = regNumero.hasMatch(value);
//       if (!tieneNumeros) {
//         return getErrors ? 'Ingrese al menos un número.' : '';
//       }
//       if (cedulaCliente != null && cedulaCliente.isNotEmpty) {
//         if (value.contains(cedulaCliente) ||
//             value.toUpperCase().contains(cedulaCliente)) {
//           return getErrors
//               ? 'La contraseña no puede contener la identificación del cliente.'
//               : '';
//         }
//       }
//       if (username != null && username.isNotEmpty) {
//         if (value.contains(username) ||
//             value.toUpperCase().contains(username)) {
//           return getErrors
//               ? 'La contraseña no puede contener el nombre de usuario.'
//               : '';
//         }
//       }
//       bool tieneCaracteresEspeciales = caracteresEspeciales.hasMatch(value);
//       if (!tieneCaracteresEspeciales) {
//         return getErrors
//             ? 'Ingrese al menos uno de los siguientes caracteres especiales: & . - _ \\ @ / \$ # *'
//             : '';
//       }
//       /*
//       final RegExp otros = RegExp(r'[^0-9a-zA-Z&.\-_\\@\/$#*ñ!]');
//       bool tieneOtros = otros.hasMatch(value);
//       if (tieneOtros) {
//         return getErrors ? 'La contraseña tiene caracteres no permitidos.' : '';
//       }
//       */
//     } else {
//       if (otroControladorDeTexto?.text != null) {
//         if (otroControladorDeTexto!.text.isNotEmpty) {
//           if (value != otroControladorDeTexto.text) {
//             return getErrors ? 'Las contraseñas no coinciden.' : '';
//           }
//         } else {
//           return getErrors ? 'Primero ingrese su contraseña.' : '';
//         }
//       }
//     }
//     return null;
//   }
//
//   static openScreen(String routeName, {bool quitarTodo = false}) {
//     if (quitarTodo) {
//       Navigator.pushNamedAndRemoveUntil(
//           navigatorKey.currentContext!, routeName, (route) => false);
//     } else {
//       Navigator.pushNamed(navigatorKey.currentContext!, routeName);
//     }
//   }
//
//   static Future<void> showError(
//       {String? title,
//         String? texto,
//         String? iconPath,
//         bool isError = false,
//         bool exitScreen = false,
//         bool forceMyMessages = false}) async {
//     GlobalVars _glovalVars = GlobalVars();
//
//     Utils.ocultarTeclado();
//
//     if (!forceMyMessages) {
//       if (await checkInternet()) {
//         if (_glovalVars.mensajeUsuario != '') {
//           if (_glovalVars.mensajeUsuario.contains(';')) {
//             List<String> data = _glovalVars.mensajeUsuario.split(';');
//             if (data.length == 2) {
//               title = _glovalVars.mensajeUsuario.split(';')[0];
//               texto = _glovalVars.mensajeUsuario.split(';')[1];
//             } else if (data.length == 3) {
//               title = _glovalVars.mensajeUsuario.split(';')[1];
//               texto = _glovalVars.mensajeUsuario.split(';')[2];
//             } else {
//               texto = null;
//             }
//           } else {
//             texto = _glovalVars.mensajeUsuario;
//           }
//         } else {
//           title = (title?.isNotEmpty ?? false) ? title : null;
//           texto = null;
//           /*
//           title = (title?.isNotEmpty ?? false) ? title : null;
//           texto = (texto?.isNotEmpty ?? false) ? texto : null;
//           */
//         }
//       } else {
//         title = 'Lo sentimos';
//         texto = 'Error de conexión. Por favor intenta más tarde.';
//         isError = true;
//       }
//     }
//
//     await showDialog(
//       context: navigatorKey.currentContext!,
//       barrierDismissible: !exitScreen,
//       builder: (context) {
//         return GeneralPopUp(
//             context: context,
//             title: (Utils.fixString(title) ?? 'Estimado cliente').toUpperCase(),
//             text: (Utils.fixString(texto) == null ||
//                 Utils.fixString(texto) == 'false'
//                 ? 'Te pedimos disculpas, por favor intenta más tarde.'
//                 : Utils.fixString(texto))
//                 .toString()
//                 .toUpperCase(),
//             iconPath:
//             iconPath ?? (isError ? imgError.path : imgAdvertencia.path),
//             mainAction: exitScreen
//                 ? () {
//               _glovalVars.mensajeUsuario = '';
//               Navigator.pop(context);
//               Navigator.pop(context);
//             }
//                 : null);
//       },
//     );
//     _glovalVars.mensajeUsuario = '';
//   }
//
//   // Completa con ceros el numero de cel
//   static String completeNumberCell(String value) {
//     while (value.length < 10) {
//       value = '*' + value;
//     }
//     return value;
//   }
//
//   //Notificacion Descargar Certificado Estado de Cuenta
//   static Future<void> showNotificacionDescargaCertificado(
//       {String? title,
//         String? texto,
//         bool isError = false,
//         bool exitScreen = false}) async {
//     await showDialog(
//         context: navigatorKey.currentContext!,
//         barrierDismissible: !exitScreen,
//         builder: (context) {
//           return GeneralPopUp(
//               context: context,
//               title: title ?? 'Notificación',
//               text: texto ?? 'Certificado Descargado Correctamente.',
//               iconPath: isError ? imgExitoso.path : imgExitoso.path,
//               mainAction: exitScreen
//                   ? () {
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               }
//                   : null);
//         });
//   }
//
// ////////
//   static String getLetters(String nombreBeneficiario) {
//     List<String> names = nombreBeneficiario.split(' ');
//     String finalString = '';
//     if (names.isNotEmpty) {
//       switch (names.length) {
//         case 2:
//           if (names[1].isNotEmpty) {
//             finalString = names[1][0];
//           }
//           break;
//         case 3:
//           if (names[2].isNotEmpty) {
//             finalString = names[2][0];
//           } else {
//             if (names[1].isNotEmpty) {
//               finalString = names[1][0];
//             }
//           }
//           break;
//         case 4:
//           if (names[2].isNotEmpty) {
//             finalString = names[2][0];
//           }
//           break;
//         case 5:
//           if (names[3].isNotEmpty) {
//             finalString = names[3][0];
//           }
//           break;
//         case 6:
//           if (names[4].isNotEmpty) {
//             finalString = names[4][0];
//           }
//           break;
//         case 7:
//           if (names[5].isNotEmpty) {
//             finalString = names[5][0];
//           }
//           break;
//       }
//     }
//     if (names[0].isNotEmpty) {
//       finalString += names[0][0];
//     }
//     return finalString;
//   }
//
//   static String getNames(String nombreLegal, {bool getApellido = false}) {
//     List<String> names = nombreLegal.split(' ');
//     String finalString = '';
//     if (names.isNotEmpty) {
//       switch (names.length) {
//         case 2:
//           finalString = names[1];
//           break;
//         case 3:
//           finalString = names[2];
//           break;
//         case 4:
//           finalString = names[2];
//           break;
//         case 5:
//           finalString = names[3];
//           break;
//         case 6:
//           finalString = names[4];
//           break;
//         case 7:
//           finalString = names[5];
//           break;
//       }
//     }
//     return finalString;
//   }
//
//   static List<String> get4Names(String datos) {
//     List<String> names = ['', '', '', ''];
//     List<String>? vectorNames;
//     vectorNames = datos.split(' ');
//
//     if (vectorNames.length == 1) {
//       names[0] = vectorNames.first;
//     } else {
//       names[2] = vectorNames.first;
//     }
//     if (vectorNames.length == 2) {
//       names[0] = vectorNames.last;
//     } else if (vectorNames.length == 3) {
//       names[0] = vectorNames.last;
//       names[3] = vectorNames[1];
//     } else if (vectorNames.length == 4) {
//       names[0] = vectorNames[2];
//       names[1] = vectorNames.last;
//       names[3] = vectorNames[1];
//     } else if (vectorNames.length == 5) {
//       names[1] = vectorNames.last;
//       if (vectorNames[1].length > 3) {
//         names[0] = vectorNames[2];
//         names[3] = vectorNames[1];
//       } else {
//         names[0] = vectorNames[3];
//         names[3] = vectorNames[2];
//       }
//     } else if (vectorNames.length == 6) {
//       if (vectorNames[2].length <= 3) {
//         names[0] = vectorNames[4];
//         names[1] = vectorNames.last;
//         names[3] = vectorNames[3];
//       } else {
//         if (vectorNames[1].length <= 3) {
//           names[0] = vectorNames[4];
//           names[1] = vectorNames.last;
//           names[3] = vectorNames[3];
//         } else {
//           names[0] = vectorNames[4];
//           names[1] = vectorNames.last;
//           names[3] = vectorNames[1];
//         }
//       }
//     } else if (vectorNames.length == 7) {
//       names[0] = vectorNames[5];
//       names[1] = vectorNames.last;
//       names[3] = vectorNames[3];
//     }
//     return names;
//   }
//
//   static Future<String> getPublicIp() async {
//     //GlobalVars().miIp = '38.132.103.221';
//     String? miIp = GlobalVars().miIp;
//     if (miIp != null && miIp != '0.0.0.0') {
//       return miIp;
//     } else {
//       try {
//         Response response =
//         await get(Uri.parse(Environment().config!.endPoints['get_ip']!));
//         if (response.statusCode == 200) {
//           GlobalVars().miIp = jsonDecode(response.body)['ip'];
//           return jsonDecode(response.body)['ip'];
//         } else {
//           // The request failed with a non-200 code
//           // The ipify.org API has a lot of guaranteed uptime
//           // promises, so this shouldn't ever actually happen.
//           debugPrint(response.statusCode.toString());
//           debugPrint(response.body);
//           return '0.0.0.0';
//         }
//       } catch (e) {
//         // Request failed due to an error, most likely because
//         // the phone isn't connected to the internet.
//         debugPrint(e.toString());
//         return '0.0.0.0';
//       }
//     }
//   }
//
//   static Future<String> getCountryCode() async {
//     String? myCountryCode = GlobalVars().miCountryCode;
//     if (myCountryCode != null && myCountryCode != '') {
//       return myCountryCode;
//     } else {
//       try {
//         Response response = await post(
//           Uri.parse(Environment().config!.endPoints['geo_ip']!),
//           body: await Utils.getPublicIp(),
//         );
//         if (response.statusCode == 200) {
//           GlobalVars().miCountryCode = response.body;
//           return response.body;
//         } else {
//           // The request failed with a non-200 code
//           // The ipify.org API has a lot of guaranteed uptime
//           // promises, so this shouldn't ever actually happen.
//           debugPrint(response.statusCode.toString());
//           debugPrint(response.body);
//           return '';
//         }
//       } catch (e) {
//         // Request failed due to an error, most likely because
//         // the phone isn't connected to the internet.
//         debugPrint(e.toString());
//         return '';
//       }
//     }
//   }
//
//   static String enmascarar(String textPlano, String tipo) {
//     if (textPlano.isNotEmpty) {
//       if (tipo == 'cuenta') {
//         List<String> vector = textPlano.split('');
//         for (int i = 0; i < vector.length; i++) {
//           if (i >= 2 && i <= vector.length - 3) {
//             vector[i] = 'X';
//           }
//         }
//         return vector.join('');
//       } else if (tipo == 'tarjeta') {
//         List<String> vector = textPlano.split('');
//         for (int i = 0; i < vector.length; i++) {
//           if (i >= 6 && i <= vector.length - 5) {
//             vector[i] = 'X';
//           }
//         }
//         return vector.join('');
//       } else if (tipo == 'celular') {
//         if (textPlano.length == 10) {
//           return '09XXXXX${textPlano.substring(7)}';
//         } else if (textPlano.length == 9) {
//           return '9XXXXX${textPlano.substring(6)}';
//         }
//       } else if (tipo == 'correo' || tipo == 'email') {
//         List<String> vector = textPlano.split('@');
//         String email = vector[0];
//         int numeroDeXs = email.length - 2;
//         String emailFinal = email[0];
//         for (int i = 0; i < numeroDeXs; i++) {
//           emailFinal += 'X';
//         }
//         emailFinal += email[email.length - 1];
//         emailFinal += ('@' + vector[1]);
//         return emailFinal;
//       }
//     }
//     return 'Error';
//   }
//
//   static String? detectNames(datos) {
//     String? nombres;
//     if (datos!.contains('NOMBRES')) {
//       nombres = datos!
//           .substring(datos!.indexOf('NOMBRES') + 8, datos!.indexOf('LUGAR') - 1)
//           .replaceAll('\n', ' ');
//
//       // Creamos un vector con los nombre
//       List<String> vectorNombres = nombres!.split(' ');
//       int? indice;
//       // Iteramos por cada nombre
//       for (String nombre in vectorNombres) {
//         // Si se detecto la cédula como un nombre se lo elimina
//         if (nombre.contains('NO') && nombre.contains('-')) {
//           indice = vectorNombres.indexOf(nombre);
//           break;
//         }
//       }
//       if (indice != null) {
//         vectorNombres.removeAt(indice);
//       }
//       // Se vuelve a forma la String desde el vector.
//       nombres = vectorNombres.join(' ');
//     }
//     return nombres;
//   }
//
//   static String? fixString(String? string) {
//     return string
//         ?.replaceAll('Ã', 'Á')
//         .replaceAll('Ã', 'É')
//         .replaceAll('Ã', 'Í')
//         .replaceAll('Ã', 'Ó')
//         .replaceAll('Ã', 'Ú')
//         .replaceAll('Ã', 'Ñ')
//         .replaceAll('Ã¡', 'á')
//         .replaceAll('Ã©', 'é')
//         .replaceAll('Ã­', 'í')
//         .replaceAll('Ã³', 'ó')
//         .replaceAll('Ãº', 'ú')
//         .replaceAll('Ã±', 'ñ')
//         .replaceAll('Â´', '\'');
//   }
//
//   static String? fixBase64String(String malformedBase64) {
//     return malformedBase64
//         .replaceAll('\n', '')
//         .replaceAll('\\n', '')
//         .replaceAll('\\', '')
//         .replaceAll(' ', '');
//   }
//
//   static Future<void> ocultarTeclado() async {
//     if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
//       FocusManager.instance.primaryFocus?.unfocus();
//       await Future.delayed(const Duration(milliseconds: 500), () {});
//     }
//   }
//
//   static formatDollars(String? dollarsString, {bool asNumber = false}) {
//     if (dollarsString?.isNotEmpty ?? false) {
//       String myNewString = dollarsString!
//           .replaceAll('\$', '')
//           .replaceAll(' ', '')
//           .replaceAll(',', '')
//           .trim();
//       if (myNewString.contains('.') &&
//           (myNewString.split('.')[1] == '0' ||
//               myNewString.split('.')[1] == '00')) {
//         myNewString = myNewString.split('.')[0];
//       }
//       if (asNumber) {
//         return num.tryParse(myNewString) ?? 0;
//       }
//       return myNewString;
//     }
//     if (asNumber) {
//       return 0;
//     }
//     return '';
//   }
//
//   /// Dar formato moneda a partir de un String
//   static formatMoney(String value) {
//     double valueDouble = double.parse(value);
//     final formatter = NumberFormat('###,###.###', 'en_US');
//     String newValueText = formatter.format(valueDouble);
//     List<String> formatValueText = newValueText.split('.');
//     if (formatValueText.length < 2) {
//       newValueText += '.00';
//     } else if (formatValueText[1].length < 2) {
//       newValueText = newValueText + '0';
//     }
//     return newValueText;
//   }
//
//   /// Obtener el tipo de cuenta para mostrar
//   static getTipoCuenta(value) {
//     String tipoCuenta = '';
//     if (value.toString().toUpperCase().contains('AHORROS') ||
//         value.toString().toUpperCase().contains('AHORRO') ||
//         value.toString().toUpperCase().contains('AHO') ||
//         value.toString().toUpperCase().contains('02')) {
//       tipoCuenta = 'AHO';
//     } else {
//       tipoCuenta = 'CTE';
//     }
//     return tipoCuenta;
//   }
//
//   static String? getVUError(int error) {
//     String? errorMessage;
//     if (error == 904) {
//       // END_OPERATION_FAIL
//       errorMessage =
//       'Tu proceso no supera nuestros criterios de aceptación. Intenta nuevamente.';
//     } else if (error == 1911 || error == 1913) {
//       /// ANALYZE_DOCUMENT_FAIL
//       errorMessage =
//       'El documento no cumple con los criterios de aceptación o se encuentra expirado. Intenta nuevamente.';
//     } else if (error == 964) {
//       /// ANALYZE_DOCUMENT_FAIL
//       errorMessage =
//       'La imagen del documento está borrosa, no pudimos analizar el documento';
//     } else if (error == 965) {
//       /// FRONT_BACK_COUNTRY_DONT_MATCH
//       errorMessage =
//       'La parte frontal y posterior del documento, corresponden a distintos países.';
//     } else if (error == 966) {
//       /// FRONT_BACK_COUNTRY_VERSION_DONT_MATCH
//       errorMessage =
//       'La parte frontal y posterior del documento, corresponden a distintos documentos.';
//     } else if (error == 967) {
//       /// FRONT_COUNTRY_DONT_MATCH
//       errorMessage =
//       'Al parecer, el documento escaneado no es una cédula ecuatoriana.';
//     } else if (error == 101 || error == 201 || error == 301) {
//       // USER_CANCELLED
//       errorMessage = 'Operación cancelada.';
//     } else if (error == 102 || error == 202 || error == 302 || error == 310) {
//       // GOOGLE_SERVICES_NOT_AVAILABLE
//       errorMessage =
//
//       /// 'Google Play Services no está disponible o no es compatible';
//       'El servicio no es compatible con su dispositivo.';
//     } else if (error == 103 || error == 203 || error == 303) {
//       // SCREEN_RECORDING_ERROR
//       errorMessage = 'No se pudo inicar la grabación.';
//     } else if (error == 104 || error == 204 || error == 304) {
//       // STORAGE_PERMISSION_DENIED
//       errorMessage =
//       'Se denegó el permiso de almacenamiento para la grabación.';
//     } else if (error == 105 || error == 205 || error == 305) {
//       // CAMERA_PERMISSION_DENIED
//       errorMessage = 'Se denegó el permiso para iniciar el uso de la cámara.';
//     } else if (error == 106 || error == 206 || error == 306) {
//       // BACKGROUND_TASKING_ERROR
//       errorMessage =
//       'Se intentó dejar la app en segundo plano mientras realizaba la captura.';
//     } else if (error == 107) {
//       // DOCUMENT_FACE_NOT_FOUND
//       errorMessage = 'No se encontró la foto de su rostro.';
//     } else if (error == 207) {
//       // BARCODE_NOT_FOUND
//       errorMessage =
//       '¡NO HEMOS PODIDO DETECTAR EL CÓDIGO DE BARRAS!, POR FAVOR ASEGÚRATE QUE LA FOTO DE TU CÉDULA DE INDENTIDAD SEA CLARA E INTÉNTALO NUEVAMENTE.';
//     } else if (error == 307) {
//       // MAX_BLOCK_DETECTED
//       errorMessage = 'SE SUPERÓ LA CANTIDAD MÁXIMA DE BLOQUES.';
//     } else if (error == 308) {
//       // MAX_INACTIVITY_DETECTED
//       errorMessage = 'SE SUPERÓ EL TIEMPO MÁXIMO DE INACTIVIDAD.';
//     } else if (error == 309) {
//       // TEST_FAILED
//       errorMessage = 'SU PRUEBA NO SUPERÓ NUESTROS CRITERIOS DE ACEPTACIÓN.';
//     } else if (error == 311) {
//       // GOOGLE_SERVICES_UPDATING
//       errorMessage =
//       'EL SERVICIO DE GOOGLE PLAY SERVICES SE ESTÁ ACTUALIZANDO. INTENTA NUEVAMENTE';
//     } else if (error == 312) {
//       // GOOGLE_SERVICES_VERSION_UPDATE_REQUIRED
//       errorMessage =
//       'EL SERVICIO DE GOOGLE PLAY SERVICES ESTÁ DESACTUALIZADO. ACTUALICE E INTENTE NUEVAMENTE';
//     } else if (error == 313) {
//       // GOOGLE_SERVICES_DISABLED
//       errorMessage =
//       'EL SERVICIO DE GOOGLE PLAY SERVICES ESTÁ DESHABILITADO. HABILITE E INTENTE NUEVAMENTE';
//     } else if (error == 9090 || error == 9120) {
//       // ADD_FRONT_FAIL // ADD_BACK_FAIL
//       errorMessage = 'No se pudo agregar agregar el documento.';
//     } else if (error == 9091) {
//       // ADD_FRONT_ML_DOCUMENT_FACE_ANTISPOOFING_FAIL
//       errorMessage =
//       'Su foto no supera las pruebas de suplantación de identidad.';
//     } else if (error == 910 || error == 913) {
//       // ADD_FRONT_ML_ANTISPOOFING_FAIL // ADD_BACK_ML_ANTISPOOFING_FAIL
//       errorMessage =
//       'Su documento no supera las pruebas de suplantación de identidad.';
//     } else if (error == 911) {
//       // FRONT_ALREADY_EXIST
//       errorMessage = 'Usted ya agregó la foto del frente de su documento.';
//     } else if (error == 914) {
//       // BACK_ALREADY_EXIST
//       errorMessage =
//       'Usted ya agregó la foto de la parte posterior de su documento.';
//     } else if (error == 916) {
//       // ADD_OCR_FAIL
//       errorMessage = 'No se pudo leer el texto del documento.';
//     } else if (error == 926) {
//       // ADD_OCR_FAIL
//       errorMessage = 'No se pudo obtener las anomalías del documento.';
//     } else if (error == 935) {
//       // SCORE_EMPTY_FRONT
//       errorMessage = 'No se encuentra el frente del documento.';
//     } else if (error == 936) {
//       // SCORE_EMPTY_SELFIE
//       errorMessage = 'No se encuentra la selfie neutral.';
//     } else if (error == 946) {
//       // ADD_ATTACHMENT_FAIL
//       errorMessage = 'El archivo adjunto no se pudo agregar.';
//     } else if (error == 962) {
//       // ADD_DOCUMENTDATA_FAIL
//       errorMessage = 'Hubo un error al agregar la información de la persona.';
//     } else if (error == 2023) {
//       // FACE_IMAGE_BACKGROUND_ICAO_FAIL
//       errorMessage = 'Por favor, utilice un fondo sin objetos.';
//     } else if (error == 2025 ||
//         error == 2028 ||
//         error == 2029 ||
//         error == 2031) {
//       // FACE_IMAGE_MONOCHROMATIC_BALANCE_FAIL
//       // FACE_IMAGE_SCREEN_PLOT_FAIL
//       // FACE_IMAGE_SCREEN_SWEEP_FAIL
//       // FACE_IMAGE_LINES_DETECTION_FAIL
//       errorMessage = 'Sus fotos no son válidas o no son de un documento real.';
//     } else if (error == 2027) {
//       // FACE_IMAGE_BACKGROUND_CROSSCHECK_FAIL
//       errorMessage = 'Los fondos en sus fotos no son los mismos.';
//     } else if (error == 2030) {
//       // FACE_IMAGE_FLASHLIGHT_SPOT_FAIL
//       errorMessage = 'Recuerde no utilizar el flash.';
//     } else if (error == 2032) {
//       // FACE_IMAGE_ML_ANTISPOOFING_FAIL
//       errorMessage =
//       'Sus pruebas no superar la validación de suplantación de identidad.';
//     } else if (error == 2033) {
//       // FACE_IMAGE_SIZE_FAIL
//       errorMessage = 'Sus fotos no son del tamaño necesario.';
//     } else if (error == 2034) {
//       // FACE_FACE_SIZE_FAIL
//       errorMessage = 'El tamaño de su rostro es inválido.';
//     } else if (error == 2035) {
//       // FACE_NO_GLASSES_FAIL
//       errorMessage = 'Por favor, recuerde no utilizar lentes o gafas.';
//     } else if (error == 3002) {
//       // REGISTER_FAIL
//       errorMessage =
//       'No se pudo completar el registro de sus pruebas biométricas.';
//     } else if (error == 3011) {
//       // CROSSCHECK_FAIL
//       errorMessage =
//       'Su proceso no superan nuestras validaciones de seguridad.';
//     } else if (error == 3012) {
//       // CROSSCHECK_EDITED_IMAGE_FAIL
//       errorMessage =
//       'Su proceso no superan nuestras validaciones de seguridad. Los resultados indican que las 3 pruebas de vida parecen la misma imagen O las imágenes enviadas fueron editadas o vulneradas.';
//     } else if (error == 904) {
//       // END_OPERATION_FAIL
//       errorMessage =
//       'Su proceso no superan nuestras validaciones de seguridad.';
//     } else if (error == 1300 || error == 1301) {
//       /// NUEVOS MENSAJES
//       /// PONDERATION_COMPONENT_CONFIGURATION_EMPTY
//       /// PONDERATION_COMPONENT_REQUIRED_NOT_PRESENT
//       errorMessage =
//       'La cédula escaneada no es válida o no es un documento real, por favor considera repetir el proceso.';
//     } else if (error == 1305) {
//       /// PONDERATION_PROCESS_DOCUMENT_DATA_ERROR
//       errorMessage =
//       'NO se encontró los datos necesarios en el documento, para continuar con el proceso.';
//     } else if (error == 1306 || error == 1307) {
//       /// PONDERATION_PROCESS_DOCUMENT_ANOMALIES_ERROR
//       errorMessage =
//       'Se encontraron anmalías en su documento, considera repetir el proceso.';
//     } else if (error == 1308) {
//       errorMessage = 'El documento no coincide con sus datos biométricos.';
//     } else if (error == 1320 || error == 1327) {
//       /// PONDERATION_OCR_VS_BARCODE_ERROR
//       errorMessage =
//       'El documento escaneado no es válido, recuerde que la falsificación de documentos es un delito.';
//     } else if (error == 9012) {
//       /// DOCUMENT_NOT_VALID
//       errorMessage = 'El documento escaneado no es válido.';
//     } else if (error == 2001) {
//       /// FACE_NOT_FOUND
//       errorMessage = 'No se detectó rostro en la selfie.';
//     } else if (error == 2004) {
//       /// FACE_DETECT_FAIL
//       errorMessage = 'El rostro no pudo ser detectado por nuestra aplicación.';
//     } else if (error == 2009) {
//       /// FACE_USER_NOT_EXISTS
//       errorMessage = 'El usuario que se intenta eliminar, no existe.';
//     } else if (error == 2010) {
//       /// FACE_USER_LOCKED
//       errorMessage =
//       'El usuario fue bloqueado por haber superado la cantidad de intentos.';
//     } else if (error == 2011) {
//       /// FACE_USER_DELETED
//       errorMessage = 'El usuario fue eliminado correctamente.';
//     } else if (error == 2012) {
//       /// FACE_USER_UNLOCKED
//       errorMessage = 'El usuario fue desbloqueado correctamente.';
//     } else if (error == 2013) {
//       /// FACE_USER_UNLOCKED_FAIL
//       errorMessage =
//       'El usuario que se intenta desbloquear, no se encuentra bloqueado.';
//     } else if (error == 2015) {
//       /// FACE_AGAINST_REGISTERED_INVALID
//       errorMessage =
//       'Su rostro no coincide con el de nuestros registros. Intente nuevamente.';
//     } else if (error == 2018) {
//       /// FACE_LOGIN_INFORMATION_NOT_EXISTS
//       errorMessage =
//       'No se obtuvo información debido a que no se realizó ningún login.';
//     } else if (error == 2019) {
//       /// FACE_LOGIN_INFORMATION_OK
//       errorMessage = 'La información del login se obtuvo correctamente.';
//     } else if (error == 5002) {
//       /// BARCODE_SCAN_NOT_DETECTED
//       errorMessage =
//       'El escaneo de código de barras falló. La imagen no es nítida.';
//     } else if (error == 2036) {
//       /// FACE_IDENTIFICATION_FAIL
//       errorMessage = 'La identificación del rostro falló.';
//     } else if (error == 1011) {
//       /// USER_EXISTS_IDENTIFIED
//       errorMessage = 'El usuario que se intenta registrar ya existe.';
//     } else if (error == 1100) {
//       /// OPERATION_USER_NOT_EXISTS
//       errorMessage = 'El usuario que se quiere desbloquear no existe.';
//     } else if (error == 1101) {
//       /// OPERATION_USER_LOCKED
//       errorMessage = 'El usuario está bloqueado.';
//     } else if (error == 1102) {
//       /// OPERATION_USER_UNLOCKED_NO_CHANGE_MADE
//       errorMessage =
//       'El usuario que se intenta desbloquear no se encuentra bloqueado.';
//     } else if (error == 1103) {
//       /// OPERATION_USER_UNLOCKED
//       errorMessage = 'El usuario fue desbloqueado correctamente.';
//     } else if (error == 1104) {
//       /// OPERATION_USER_ALREADY_UNLOCKED
//       errorMessage =
//       'El usuario que se intenta desbloquear ya se encuentra desbloqueado.';
//     } else if (error == 1106) {
//       /// UNLOCK_USER_FAILED
//       errorMessage = 'El desbloqueo del usuario falló.';
//     } else if (error == 13101) {
//       /// INFORMATION_PERSON_GOVERNMENT_SERVICE_FAIL
//       errorMessage =
//       'Hubo un error en la base de datos del servicio gubernamental y no se puede obtener la información de la persona.';
//     } else if (error == 13102) {
//       /// INFORMATION_PERSON_GOVERNMENT_SERVICE_CONFIG_FAIL
//       errorMessage =
//       'Hubo un error al obtener la configuración del servicio de información gubernamental.';
//     } else if (error == 13104) {
//       /// INFORMATION_PERSON_GOVERNMENT_SERVICE_NOT_VALID_DOCUMENT
//       errorMessage = 'El documento no es válido.';
//     } else if (error == 13201) {
//       /// INFORMATION_FINANCIAL_SERVICE_FAIL
//       errorMessage = 'Hubo un error al obtener los datos financieros.';
//     } else if (error == 13301) {
//       /// INFORMATION_TERRORISM_SERVICE_FAIL
//       errorMessage = 'Hubo un error al obtener los datos de terrorismo.';
//     }
//     return errorMessage;
//   }
//
//   static Future<String> getUserUIDD() async {
//     String miUidd = GlobalVars().miUuid;
//     if (miUidd.isNotEmpty) {
//       return miUidd;
//     } else {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//       String uuid = 'Desconocido';
//       try {
//         if (Platform.isIOS) {
//           uuid = 'iOS,' +
//               ((await deviceInfo.iosInfo).identifierForVendor ??
//                   (await UniqueIdentifier.serial ?? ''));
//         } else {
//           uuid = 'Android,' + (await UniqueIdentifier.serial ?? '');
//         }
//         if (uuid == 'iOS,' || uuid == 'Android,') {
//           uuid = 'Desconocido';
//         }
//         GlobalVars().miUuid = uuid;
//       } on PlatformException {
//         uuid = 'Desconocido';
//       }
//       return uuid;
//     }
//   }
//
//   static String generateMensajeSesion() {
//     return 'MBL2022jun04103020000982044';
//   }
//
//   static Future<String?> descargarComprobante(
//       Container Function() comprobante) async {
//     /// Se comprueban y piden los permisos necesarios
//     PermissionStatus status = await Permission.storage.status;
//     if (status == PermissionStatus.permanentlyDenied) {
//       return 'Usted negó los permisos de almacenamiento permanentemente. No se puede descargar el comprobante.';
//     } else {
//       if (status == PermissionStatus.denied ||
//           status == PermissionStatus.limited ||
//           status == PermissionStatus.restricted) {
//         status = await Permission.storage.request();
//         if (status != PermissionStatus.granted) {
//           return 'No nos concedió los permisos necesarios. Intente nuevamente.';
//         }
//       }
//     }
//
//     /// Si tenemos los permisos
//     if (status == PermissionStatus.granted) {
//       /// Creamos la imagen
//       Uint8List? image = await ScreenshotController()
//           .captureFromWidget(comprobante(), delay: const Duration(seconds: 1));
//
//       Uint8List imagenFinal =
//       Uint8List.fromList(encodePng(decodeImage(image)!));
//
//       String dir = (await getTemporaryDirectory()).path;
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//
//       File imageFile =
//       await File('$dir/ComprobanteBAustroTransferencia_$fileName.png')
//           .writeAsBytes(imagenFinal);
//
//       /// Si se creó la imagen, la guardamos en la galería.
//       final result = await ImageGallerySaver.saveFile(imageFile.path,
//           name: 'ComprobanteBAustroTransferencia_$fileName.png');
//       if (result['isSuccess']) {
//         return null;
//       } else {
//         return 'No se pudo guardar el comprobante. Intenta nuevamente.';
//       }
//     }
//     return 'general';
//   }
//
//   static Future<void> shareComprobante(Container Function() comprobante) async {
//     Uint8List? image = await ScreenshotController()
//         .captureFromWidget(comprobante(), delay: const Duration(seconds: 1));
//
//     Uint8List imagenFinal = Uint8List.fromList(encodePng(decodeImage(image)!));
//
//     String dir = (await getTemporaryDirectory()).path;
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//
//     File imageFile =
//     await File('$dir/ComprobanteBAustroTransferencia_$fileName.png')
//         .writeAsBytes(imagenFinal);
//
//     /// Share Plugin
//     await Share.shareFiles([imageFile.path]);
//   }
//
//   static Future<bool> checkInternet() async {
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } on SocketException catch (_) {}
//     return false;
//   }
//
//   static void mostrarDialogoCerrarSesion() {
//     showDialog(
//       barrierDismissible: false,
//       context: navigatorKey.currentContext!,
//       builder: (context) {
//         return GeneralPopUp(
//             dismissible: false,
//             context: context,
//             title: 'LO SENTIMOS...',
//             mainText: 'Aceptar',
//             iconPath: imgAdvertencia.path,
//             text: RichText(
//               text: TextSpan(
//                 style: blue.copyWith(fontSize: 13.8),
//                 children: [
//                   TextSpan(
//                       text:
//                       'EL TIEMPO DE TU SESIÓN HA CADUCADO.'.toUpperCase()),
//                 ],
//               ),
//               textAlign: TextAlign.center,
//             ),
//             horizontalFormat: false,
//             fontSize: 14,
//             mainAction: () {
//               cerrarSesion(context);
//             });
//       },
//     );
//   }
//
//   static void cerrarSesion(BuildContext context) async {
//     LogoutController().cerrarSesion();
//     GlobalVars().clearAllVars();
//     Navigator.pushNamedAndRemoveUntil(context, HomePage.name, (route) => false);
//   }
// }
//
// class UpperCaseTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     return TextEditingValue(
//       text: newValue.text.toUpperCase(),
//       selection: newValue.selection,
//     );
//   }
// }
