import 'package:flutter/material.dart';
import 'package:loadfile_baustro/apps/home/register.dart';
import 'package:loadfile_baustro/apps/home/shops.dart';
import 'package:loadfile_baustro/apps/splash/splash.dart';

import '../apps/home/home.dart';
import '../core/screens/error_screen.dart';
import '../core/screens/settings_screen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),

  HomeScreen.name: (BuildContext context) => HomeScreen(),
  RegisterScreen.name: (BuildContext context) => RegisterScreen(),
  GenerateShopScreen.name: (BuildContext context) => GenerateShopScreen(),

  SettingsScreen.name: (BuildContext context) => SettingsScreen(),
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

/// Generacion de Rutas cuando no existen en los metodos [onGenerateRouters] o
/// [routers]
Route<dynamic> Function(RouteSettings) onUnknownRoutes =
    (RouteSettings settings) {
  return MaterialPageRoute(builder: (context) => const ErrorScreen());
};
