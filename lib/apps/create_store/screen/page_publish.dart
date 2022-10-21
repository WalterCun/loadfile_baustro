import 'package:flutter/material.dart';

import '../../../core/db/manager.dart';

class PublishedPage extends StatefulWidget {
  const PublishedPage({Key? key}) : super(key: key);

  @override
  State<PublishedPage> createState() => _PublishedPageState();
}

class _PublishedPageState extends State<PublishedPage> {
  final data = DataProvider();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      child: const Text('Marketing'),
    );
  }
}
