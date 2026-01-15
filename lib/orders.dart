import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _Orders createState() => _Orders();
}

class _Orders extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'Coming soon...',
        textAlign: TextAlign.center,
      ),
    ));
  }
}
