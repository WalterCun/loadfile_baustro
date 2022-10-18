import 'package:flutter/material.dart';

import '../apps/splash/splash.dart';
import '../apps/create_store/register.dart';
import '../apps/create_store/shops.dart';
import '../apps/create_store/home.dart';
import '../core/screens/error_screen.dart';
import '../core/screens/settings_screen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => const SplashScreen(),

  HomeScreen.name: (BuildContext context) => const HomeScreen(),
  RegisterScreen.name: (BuildContext context) => const RegisterScreen(),
  GenerateShopScreen.name: (BuildContext context) => const GenerateShopScreen(),

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
