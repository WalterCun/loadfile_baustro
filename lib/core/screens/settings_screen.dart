// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:loadfile_baustro/core/screens/base_screen.dart';


class SettingsScreen extends StatefulWidget {
  static const String name = 'settings/';

  SettingsScreen({Key? key}) : super(key: key);

  // final store = LocalStorageManager();

  late String language;
  late String languageSubtitle;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      // appBar: CustomAppBar(
      //   leading: const LeadingReturnIconButton(),
      //   title: AppLocalizations.of(context)!.screen_home_title,
      // ),
      child:
      SettingsList(
        shrinkWrap: false,
        sections: [
          // SettingsSection(
          //   title: AppLocalizations.of(context)!.screen_home_title,
          //   tiles: [
          //     // SettingsTile(
          //     //     title: AppLocalizations.of(context)!.screen_home_title,
          //     //     subtitle: AppLocalizations.of(context)!.localeName.toUpperCase(),
          //     //     leading: const Icon(Icons.language),
          //     //     onPressed: (BuildContext context) {
          //     //       Navigator.of(context).push(MaterialPageRoute(
          //     //         builder: (_) => const LanguagesScreen(),
          //     //       ));
          //     //     }),
          //   ],
          // ),
          // SettingsSection(
          //   title: 'Account',
          //   tiles: [
          //     SettingsTile(
          //         title: 'Phone number', leading: const Icon(Icons.phone)),
          //     SettingsTile(title: 'Email', leading: const Icon(Icons.email)),
          //     SettingsTile(
          //         title: 'Sign out', leading: const Icon(Icons.exit_to_app)),
          //   ],
          // ),
          // SettingsSection(
          //   title: 'Security',
          //   tiles: [
          //     SettingsTile.switchTile(
          //       title: 'Lock app in background',
          //       theme: const SettingsTileTheme(tileColor: Colors.green),
          //       leading: const Icon(Icons.phonelink_lock),
          //       switchValue: lockInBackground,
          //       onToggle: (bool value) {
          //         setState(() {
          //           lockInBackground = value;
          //           notificationsEnabled = value;
          //         });
          //       },
          //     ),
          //     SettingsTile.switchTile(
          //       title: 'Use fingerprint',
          //       subtitle: 'Allow application to access stored fingerprint IDs.',
          //       leading: const Icon(Icons.fingerprint),
          //       onToggle: (bool value) {},
          //       switchValue: false,
          //     ),
          //     SettingsTile.switchTile(
          //       title: 'Change password',
          //       leading: const Icon(Icons.lock),
          //       switchValue: true,
          //       onToggle: (bool value) {},
          //     ),
          //     SettingsTile.switchTile(
          //       title: 'Enable Notifications',
          //       enabled: notificationsEnabled,
          //       leading: const Icon(Icons.notifications_active),
          //       switchValue: true,
          //       onToggle: (value) {},
          //     ),
          //   ],
          // ),
          // SettingsSection(
          //   title: 'Misc',
          //   tiles: [
          //     SettingsTile(
          //         title: 'Terms of Service',
          //         leading: const Icon(Icons.description)),
          //     SettingsTile(
          //         title: 'Open source licenses',
          //         leading: const Icon(Icons.collections_bookmark)),
          //   ],
          // ),
          CustomSection(
            child: TextButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.zero,
                  //   child: Image.asset(
                  //     imgSettings.path,
                  //     height: 30,
                  //     width: 30,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // const Text(
                  //   version,
                  //   style: TextStyle(color: Color(0xFF777777)),
                  // ),
                ],
              ),
              onPressed: () {
                log('On Pressed');
              },
              onLongPress: () {
                log('Long press');
              },
            ),
          ),
        ],
      ),
    );
  }
}
