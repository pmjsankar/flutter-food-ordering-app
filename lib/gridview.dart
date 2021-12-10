import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:live_menu_flutter/popular.dart';

class CountyGridView extends StatefulWidget {
  final List<Popular> country;

  CountyGridView({Key key, this.country}) : super(key: key);

  @override
  _CountyGridView createState() => _CountyGridView();
}

class _CountyGridView extends State<CountyGridView> {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.80,
      children: List.generate(widget.country.length, (index) {
        return getStructuredGridCell(widget.country[index], context);
      }),
    );
  }

  void showSheet(Popular popularObj) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 122.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(widget.country.length, (index) {
                        return getHorizontalListItem(
                            widget.country[index], context);
                      }),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularObj.title,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cera'),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                popularObj.rating,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontFamily: 'Cera'),
                              ),
                              decoration: new BoxDecoration(color: Colors.red),
                              padding: new EdgeInsets.all(4.0),
                            ),
                          ]))
                ],
              ),
            ));
  }

  Container getHorizontalListItem(Popular country, BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(country.imageUrl,
            width: 250, height: 120, fit: BoxFit.fill),
      ],
    ));
  }

  Container getStructuredGridCell(Popular popularObj, BuildContext context) {
    return Container(
      child: new Card(
          elevation: 2,
          child: InkWell(
              onTap: () => showSheet(popularObj),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Center(
                    child: Image.network(popularObj.imageUrl,
                        // width: 300,
                        height: 120,
                        fit: BoxFit.fill),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          popularObj.title,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cera'),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text(
                              popularObj.price,
                              style: TextStyle(
                                fontFamily: 'Cera',
                                color: Colors.black54,
                              ),
                            ),
                            new Text(
                              popularObj.rating,
                              style: TextStyle(
                                fontFamily: 'Cera',
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))),
      padding: EdgeInsets.all(5.0),
    );
  }
}
