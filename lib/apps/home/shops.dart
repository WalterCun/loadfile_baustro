import 'package:flutter/material.dart';

import '../../core/screens/base_screen.dart';

class GenerateShopScreen extends StatefulWidget {
  static const String name = 'generate_shop/';
  const GenerateShopScreen({Key? key}) : super(key: key);

  @override
  State<GenerateShopScreen> createState() => _GenerateShopScreenState();
}

class _GenerateShopScreenState extends State<GenerateShopScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Container(),
      floatActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        tooltip: 'Guardar Cambios',
        backgroundColor: Colors.green,
        onPressed: (){},
      ),
    );
  }
}
