import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livemenu/delivery_model.dart';
import 'package:livemenu/dining_model.dart';
import 'package:livemenu/menu_model.dart';

class Checkout extends StatefulWidget {
  final DeliveryModel obj;
  final int totalPrice;
  final List<MenuModel> selectedItems;

  Checkout({Key key, this.obj, this.selectedItems, this.totalPrice})
      : super(key: key);

  @override
  _Checkout createState() => _Checkout();
}

class _Checkout extends State<Checkout> {
  var itemAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, top: 60.0),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 60.0),
                child: Text(
                  widget.obj.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, top: 60.0),
                child: InkWell(
                  child: Icon(
                    Icons.local_offer,
                    color: Colors.orange,
                    size: 24,
                  ),
                  onTap: () {},
                )),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(
            height: 1,
            indent: 6,
            endIndent: 6,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 2),
              child: InkWell(
                child: Icon(
                  Icons.location_on_rounded,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 6, right: 2, top: 2),
              child: Text(
                'Delivery at ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(bottom: 5, left: 14, right: 10, top: 2),
              child: Text(
                widget.obj.desc,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 2),
              child: InkWell(
                child: Icon(
                  Icons.timer,
                  color: Colors.green,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 7, right: 16, top: 2),
              child: Text(
                'Delivery in ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '26 mins',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 20),
              child: InkWell(
                child: Icon(
                  Icons.fastfood,
                  color: Colors.green,
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 7, right: 16, top: 20),
              child: Text(
                'Your Order',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12, left: 16),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 2, color: Colors.green)),
                  child: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 8,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 20),
                  child: Text(
                    'Masala dosa',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 20),
              child: Text(
                '2',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                '₹80',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 0),
              child: Text(
                '₹160',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6, left: 16),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 2, color: Colors.red)),
                  child: Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 8,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 16, right: 16, top: 6),
                  child: Text(
                    'Chicken Biriyani',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 20),
              child: Text(
                '1',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                '₹160',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 0),
              child: Text(
                '₹160',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'Delivery Fee',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹24',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'Taxes & Charges',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹4.5',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'To Pay',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹' + widget.totalPrice.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 5, left: 48, right: 8, top: 0),
                    child: Text(
                      '₹' + widget.totalPrice.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 15, left: 8, right: 20, top: 14),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      label: Padding(
                        padding: EdgeInsets.only(
                            top: 12, bottom: 12, left: 10, right: 10),
                        child: Text(
                          "MAKE PAYMENT",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.done,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Container getListItem(DiningModel obj, int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12, left: 16),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 2, color: Colors.green)),
                  child: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 8,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6, left: 16, right: 10, top: 8),
                  child: Text(
                    obj.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 16, right: 10, top: 0),
                  child: Text(
                    obj.offer,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 16, right: 10, top: 0),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        itemAddedToCart = true;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: Colors.red),
                    ),
                    child: const Text(
                      "+ ADD",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(obj.imageUrl,
                    width: 100, height: 110, fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
