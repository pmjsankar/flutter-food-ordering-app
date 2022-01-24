import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/popular.dart';

import 'gridview.dart';
import 'main.dart';
import 'netwoklayer.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',
  'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1631452180539-96aca7d48617?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
];

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 60.0),
                  child: Image.asset(
                    'assets/images/ic_location.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
                Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 3.0, top: 60.0),
                    child: Text(
                      'Kakkanad, Kochi',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  isDense: true,
                  // now you can customize it here or add padding widget
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: false,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20, left: 17, right: 4),
                  width: 75.0,
                  height: 75.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                  decoration: new BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: new AssetImage("assets/images/burger.png")))),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 4, right: 4),
                  width: 75.0,
                  height: 75.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                  decoration: new BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: new AssetImage("assets/images/masala.png")))),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 4, right: 4),
                  width: 75.0,
                  height: 75.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                  decoration: new BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: new AssetImage("assets/images/pizza.png")))),
              Container(
                  margin: EdgeInsets.only(top: 20, left: 4, right: 5),
                  width: 75.0,
                  height: 75.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
                  decoration: new BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: new AssetImage("assets/images/biriyani.png"))))
            ]),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 20.0, right: 10.0, bottom: 10.0),
              child: Text(
                'Collections',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 6.0, top: 0.0, right: 6.0, bottom: 10.0),
              child: new FutureBuilder<List<Popular>>(
                future: fetchCountry(new http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? new CountyGridView(country: snapshot.data)
                      : new Center(child: new CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
