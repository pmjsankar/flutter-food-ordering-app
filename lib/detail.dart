import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 60.0),
              child: Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
            Icon(
              Icons.share,
              size: 24,
            )
          ],
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Pizza Hut',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                child: Text(
                  'Third floor, Lulu mall, Edappally',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
