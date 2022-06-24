import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livemenu/login.dart';
import 'package:livemenu/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'delivery.dart';
import 'dining.dart';
import 'orders.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',
  'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1631452180539-96aca7d48617?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
];

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  var mobileNumber;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: navigateNext(),
    );
  }

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  navigateNext() {
    if (mobileNumber != null) {
      return new HomePage();
    } else {
      return new Login();
    }
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = prefs.getString(Constants.LOGIN);
    });
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List _children = [
    Delivery(),
    Dining(),
    Orders(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return new Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: colorScheme.surface,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.green.withOpacity(.60),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            BottomNavigationBarItem(
              label: 'Delivery',
              icon: Icon(Icons.delivery_dining),
            ),
            BottomNavigationBarItem(
              label: 'Dining',
              icon: Icon(Icons.dining),
            ),
            BottomNavigationBarItem(
              label: 'Offers',
              icon: Icon(Icons.local_offer),
            ),
            BottomNavigationBarItem(
                label: 'Me', icon: Icon(Icons.library_books)),
          ],
        ));
  }
}
