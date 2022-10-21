import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loadfile_baustro/apps/create_store/screen/page_bitmaps.dart';
import 'package:loadfile_baustro/apps/create_store/screen/page_configurations.dart';
import 'package:loadfile_baustro/apps/create_store/screen/page_publish.dart';

import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:format/format.dart';

import '../../../conf/settings.dart';
import '../../../core/db/manager.dart';
import '../../../core/screens/base_screen.dart';
import '../../../core/inputformatters/inputsfomatters.dart';
import '../../../core/structs/paths.dart' show gifEsperando;
import '../../../core/themes/fonts.dart';
import '../../../core/themes/input_theme.dart';
import '../../../core/utils/util.dart';
import '../../../main.dart';
import '../create.dart';
import '../widgets/custom_tile.dart';
import '../widgets/custom_widget.dart';

class GenerateShopScreen extends StatefulWidget {
  static const String name = 'generate_shop/';
  const GenerateShopScreen({Key? key}) : super(key: key);

  @override
  State<GenerateShopScreen> createState() => _GenerateShopScreenState();
}

class _GenerateShopScreenState extends State<GenerateShopScreen> {
  final data = DataProvider();
  int currentPageIndex = 0;

  // final _formKeyParametersShop = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const destinations = [
      NavigationDestination(
        icon: Icon(Icons.store),
        selectedIcon: Icon(Icons.check),
        label: 'Bitmaps',
      ),
      NavigationDestination(
        icon: Icon(Icons.handyman),
        selectedIcon: Icon(Icons.check),
        label: 'Configurations',
      ),
      NavigationDestination(
        icon: Icon(Icons.web),
        selectedIcon: Icon(Icons.check),
        label: 'Templates',
      ),
      // NavigationDestination(
      // icon: Icon(Icons.publish),
      // selectedIcon: Icon(Icons.check),
      // label: 'Publicised',
      // ),
    ];

    return BaseScreen(
      expanded: true,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: destinations,
      ),
      floatActionButton: FloatingActionButton(
        heroTag: 'btnContruir',
        tooltip: 'CONTRUIR CARPETA',
        backgroundColor: Colors.blue,
        hoverColor: Colors.green,
        onPressed: () {
          // data.toJson().forEach((key, value) {
          //   log('$key:$value');
          // });

          createShopFiles();
        },
        child: const Icon(Icons.build),
      ),
      child: <Widget>[
        BitmapsPage(),
        ConfigurationsPage(),
        PublishedPage(),
      ][currentPageIndex],
    );
  }

  viewPopUp() {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => _buildPopupDialog(context),
    );}

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Center(child: Text('CONTRUIR COMERCIO')),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("ESTA SEGURO DE CREAR EL COMERCIO"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
