import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'apps/home/home.dart';
import 'conf/routers.dart';
import 'conf/settings.dart';
import 'l10n/l10n.dart';

main() {
  runApp(const FLoadFileApp());

  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(800,800);
    win
      ..minSize = initialSize
      ..size = initialSize
      ..maxSize = initialSize
      ..alignment = Alignment.center
      ..title = "POS DIGITAL - COMERCIOS";
    win.show();
  });

  /// Avoid errors caused by flutter upgrade.
  /// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
}

/// Navigator global, para utilizarlo en lugares sin contexto (context)
final navigatorKey = GlobalKey<NavigatorState>();

class FLoadFileApp extends StatefulWidget {
  const FLoadFileApp({super.key});

  @override
  State<FLoadFileApp> createState() => _FLoadFileAppState();
}

class _FLoadFileAppState extends State<FLoadFileApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'FILE_LOADER - GENERADOR DE COMERCIOS',
        debugShowCheckedModeBanner: DEBUG,
        navigatorKey: navigatorKey,
        initialRoute: HomeScreen.name,
        routes: routes,
        onGenerateRoute: (settings) => onGenerateRoutes(settings),
        onUnknownRoute: onUnknownRoutes,
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: L10n.localizationsDelegates,
        // locale: locale.locale,
      ),
    );
  }
}
