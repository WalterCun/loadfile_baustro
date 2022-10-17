/// Paquete de gestion de idiomas para la implementacion dentro del aplicativo.
// https://www.youtube.com/watch?v=icTT6xUYHow&list=PLtp7ENz9bQMRMzRFrnAlim_MIjOTJskTw&index=2&ab_channel=HenryCode
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Recurso del formato arb
// https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification#resource-id

// Guide for building internationalized Flutter apps
// https://docs.google.com/document/d/10e0saTfAv32OZLRmONy866vnaw0I2jwL8zukykpgWBc/edit
class L10n {
  // Sistema para traducir el documento arb en varios idiomas
  // https://localizely.com/blog/flutter-localization-step-by-step/?tab=automated-using-flutter-intl

  // Lista de códigos de internacionalizacion
  // https://www.science.co.il/language/Codes.php
  static const List<Locale> supportedLocales = [
    Locale('en'), // Ingles
    Locale('es'), // Español
    //   Locale('zh'), // Chino Mandarin
    //   Locale('hi'), // Hindi
    //   Locale('ar'), // Arabe
    //   Locale('fr'), // Frances
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
  [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
