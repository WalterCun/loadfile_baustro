import 'package:flutter/material.dart';

import '../../core/screens/base_screen.dart';

class GenerateShopScreen extends StatefulWidget {
  static const String name = 'generate_shop/';
  const GenerateShopScreen({Key? key}) : super(key: key);

  @override
  State<GenerateShopScreen> createState() => _GenerateShopScreenState();
}

class _GenerateShopScreenState extends State<GenerateShopScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      expanded: true,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.store),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      child: <Widget>[
        Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
      floatActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        tooltip: 'Guardar Cambios',
        backgroundColor: Colors.green,
        onPressed: () {},
      ),
    );
  }
}
