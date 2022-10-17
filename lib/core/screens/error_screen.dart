import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: const Center(
          child: Text(
            'Error Page',
            style: TextStyle(fontSize: 50,
                color: Colors.red),
          ),
        ),
      ),
    );
  }
}
