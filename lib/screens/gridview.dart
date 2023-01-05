import 'package:flutter/material.dart';
import 'package:livemenu/model/delivery_model.dart';
import 'package:livemenu/screens/menu.dart';

class RestaurantGridView extends StatefulWidget {
  final List<DeliveryModel> restaurantList;

  RestaurantGridView({Key key, this.restaurantList}) : super(key: key);

  @override
  _RestaurantGridView createState() => _RestaurantGridView();
}

class _RestaurantGridView extends State<RestaurantGridView> {
  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      padding: EdgeInsets.all(0),
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.78,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(widget.restaurantList.length, (index) {
        return getStructuredGridCell(widget.restaurantList[index], context);
      }),
    );
  }

  Container getStructuredGridCell(DeliveryModel obj, BuildContext context) {
    String offer = obj.offer;

    return Container(
      child: new Card(
          elevation: 2,
          child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Menu(obj: obj))),
              child: new Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(obj.imageUrl,
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
                              obj.title,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
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
                                    obj.rating,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0,
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
                                obj.desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Text(
                              obj.price,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
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

  // void showSheet(DeliveryModel obj) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) => Container(
  //             margin: EdgeInsets.all(10.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   height: 122.0,
  //                   child: ListView(
  //                     scrollDirection: Axis.horizontal,
  //                     children:
  //                         List.generate(widget.restaurantList.length, (index) {
  //                       return getHorizontalListItem(
  //                           widget.restaurantList[index], context);
  //                     }),
  //                   ),
  //                 ),
  //                 Padding(
  //                     padding: EdgeInsets.all(5.0),
  //                     child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             obj.title,
  //                             style: TextStyle(
  //                               fontSize: 16.0,
  //                               color: Colors.black87,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           Container(
  //                             margin: EdgeInsets.only(top: 5.0),
  //                             child: Text(
  //                               obj.rating,
  //                               style: TextStyle(
  //                                 fontSize: 12.0,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                             decoration:
  //                                 new BoxDecoration(color: Colors.green),
  //                             padding: new EdgeInsets.all(4.0),
  //                           ),
  //                         ]))
  //               ],
  //             ),
  //           ));
  // }

  Container getHorizontalListItem(DeliveryModel object, BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(object.imageUrl,
            width: 250, height: 120, fit: BoxFit.fill),
      ],
    ));
  }
}
