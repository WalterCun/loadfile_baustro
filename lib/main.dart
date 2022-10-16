import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:loadfile_baustro/conf/routers.dart';

// late ObjectBox objectBox;

main() {
  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(720, 720);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.show();
  });

  runApp(const FLoadFileApp());
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
    return MaterialApp(
      title: 'POS DIGITAL - GENERADOR DE COMERCIOS',
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.light,
      navigatorKey: navigatorKey,
      // theme: austroDigitalTheme,
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: (settings) => onGenerateRoutes(settings),
      // onUnknownRoute: ,
      localizationsDelegates: const [
        /// Para traducciones de widgets
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        /// Para posibles traducciones de la app
        Locale('es'), // Spanish, no country code
        Locale('en'), // English, no country code
      ],
    );
  }
}
