import 'package:flutter/material.dart';
import 'package:livemenu/model/delivery_model.dart';
import 'package:livemenu/menu.dart';

class RestaurantGridView extends StatefulWidget {
  final List<DeliveryModel> restaurantList;

  const RestaurantGridView({super.key, required this.restaurantList});

  @override
  _RestaurantGridView createState() => _RestaurantGridView();
}

class _RestaurantGridView extends State<RestaurantGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(0),
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.78,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(widget.restaurantList.length, (index) {
        return getStructuredGridCell(widget.restaurantList[index], context);
      }),
    );
  }

  Container getStructuredGridCell(DeliveryModel obj, BuildContext context) {
    String offer = obj.offer;

    return Container(
      child: Card(
          elevation: 2,
          child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Menu(obj: obj))),
              child: Column(
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue,
                              ),
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                '$offer % OFF',
                                style: const TextStyle(
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
                      padding: const EdgeInsets.only(
                          left: 6.0, right: 6.0, top: 10, bottom: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              obj.title,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0)),
                              ),
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                  Text(
                                    obj.rating,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                obj.desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Text(
                              obj.price,
                              style: const TextStyle(
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
      padding: const EdgeInsets.all(5.0),
    );
  }

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
