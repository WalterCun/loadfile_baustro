import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loadfile_baustro/core/structs/paths.dart';
import 'package:loadfile_baustro/core/themes/colors.dart';

import '../../screens/settings_screen.dart';
import '../extras/divider_widget.dart';

class DefaultDrawer extends StatefulWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  State<DefaultDrawer> createState() => _DefaultDrawerState();
}

class _DefaultDrawerState extends State<DefaultDrawer>{
  bool swich = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                _drawerHeader(),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(AppLocalizations.of(context)!.widget_drawer_button_history),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(Icons.restore_from_trash),
                  title: Text(AppLocalizations.of(context)!.widget_drawer_button_trash),
                  onTap: () {},
                ),

                // ListTile(
                //   leading: const Icon(Icons.colorize),
                //   title: const Text('Dark Theme'),
                //   trailing: Switch(
                //     value: swich,
                //     onChanged: (value) {
                //       setState(() {
                //         swich = value;
                //       });
                //     },
                //   ),
                // ),
                const CustomDivider(),
                ListTile(
                  leading: const Icon(Icons.electrical_services),
                  title: const Text('Help'),
                  onTap: () {},
                ),
                // ListTile(
                //   leading: const Icon(Icons.info_outline),
                //   title: const Text('Sobre Nosotros'),
                //   onTap: () {},
                // ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title:
                  Text(AppLocalizations.of(context)!.widget_drawer_button_settings),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed(SettingsScreen.name);
                  },
                ),
              ],
            ),
          ),
          _buttonExitApp()
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: FloadFileColors.gradientScreen,
              stops: [0.25,0.75]),
        ),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: FittedBox(child: Container(child: Image.asset(imgLogo.path))),
    );
  }

  Widget _buttonExitApp() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topCenter,
          colors: [Colors.red,Colors.orange],
          stops: [0.3,0.90]
        )
      ),
      child: ListTile(
        title: Text(AppLocalizations.of(context)!.widget_drawer_button_exit),
        trailing: const Icon(
          Icons.logout,
          color: Colors.red,
          size: 30,
        ),
        onTap: () {
          exit(0);
        },
      ),
    );
  }
}
