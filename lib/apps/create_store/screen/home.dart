import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/screens/base_screen.dart';
import '../../core/structs/paths.dart' show gifDescanzando;
import '../../core/themes/fonts.dart';
import '../../core/widgets/buttons/icon_buttons/iconbuttonmenu_widget.dart';
import '../../core/widgets/floatactionbutton/floatactionbutton_widget.dart';
import '../create_store/register.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget floatCircularButton() {
    return FloatCircularButton(
        ringWidth: 10.h, // 73 ancho de banda de menu
        ringDiameter: 60.h, // 362 diametro total ocupado del Menu
        ringColor: Colors.orange, // color de menu
        fabSize: 50,
        fabOpenIcon: const Icon(Icons.workspaces, size: 30), // icono de boton
        children: [
          IconMenuFloatButton(
            icon: Icons.add,
            tooltip: AppLocalizations.of(context)!
                .widget_floatActionButton_crearComercio,
            onPressed: () {
              Navigator.of(context).pushNamed(RegisterScreen.name);
            },
          ),
          IconMenuFloatButton(
            icon: Icons.edit,
          ),
          IconMenuFloatButton(
            icon: Icons.history,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        floatActionButton: floatCircularButton(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.screen_home_title,
                  style: blackStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                gifDescanzando.path,
                height: 75.w,
                width: 75.h,
              ),
            ],
          ),
        ));
  }
}
