import 'package:flutter/material.dart';
import 'package:loadfile_baustro/apps/splash/splash.dart';

import '../apps/home/home.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
'/': (BuildContext context) => SplashScreen(),
'home/': (BuildContext context) => HomeScreen(),
};



Route<dynamic>? onGenerateRoutes(settings) {
  /// EXAMPLE
  // if (settings.name == MovimientosCuentaScreen.routeName) {
  //   final args = settings.arguments as MisCuentas;
  //   return MaterialPageRoute<bool?>(
  //     builder: (context) {
  //       return MovimientosCuentaScreen(
  //         cuenta: args,
  //       );
  //     },
  //   );
  // }

  assert(false, 'Se necesita implementar: ${settings.name}');
  return null;
}