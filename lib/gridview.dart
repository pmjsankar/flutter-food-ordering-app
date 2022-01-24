import 'package:flutter/material.dart';
import 'package:livemenu/popular.dart';

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
      padding: EdgeInsets.all(0),
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.86,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                popularObj.rating,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
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
    String offer = popularObj.offer;

    return Container(
      child: new Card(
          elevation: 2,
          child: InkWell(
              onTap: () => showSheet(popularObj),
              child: new Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(popularObj.imageUrl,
                          height: 120, fit: BoxFit.fill),
                      Positioned(
                        bottom: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                '$offer % OFF',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 6.0, right: 6.0, top: 10, bottom: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              popularObj.title,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cera'),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(3.0)),
                              ),
                              padding: EdgeInsets.all(1.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                  Text(
                                    popularObj.rating,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                  new Padding(
                    padding: EdgeInsets.only(left: 6.0, right: 6.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                popularObj.desc,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Cera',
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Text(
                              popularObj.price,
                              style: TextStyle(
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
