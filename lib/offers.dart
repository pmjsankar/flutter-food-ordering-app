import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  Offers({Key key}) : super(key: key);

  @override
  _Offers createState() => _Offers();
}

class _Offers extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Coming soon...',
        textAlign: TextAlign.center,
      ),
    ));
  }
}
